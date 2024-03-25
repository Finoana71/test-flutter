import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:gestiondossier/repositories/dossier_repository.dart';
import 'package:gestiondossier/services/dossier_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static const String _dbName = 'db_dossiers';

  // static Future<File> getDbFile() async {
  //   try {
  //     // Fermer la base de données avant l'exportation
  //     await DossierRepository.closeDatabase();

  //     // Attendre un court instant pour permettre la fermeture de la base de données
  //     await Future.delayed(Duration(milliseconds: 500));

  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String dbPath = join(appDocDir.path, _dbName);
  //     File originalFile = File(dbPath);

  //     if (originalFile.existsSync()) {
  //       return originalFile;
  //     } else {
  //       throw Exception("La base de données d'origine n'existe pas.");
  //     }
  //   } catch (e) {
  //     print("Erreur lors de l'exportation de la base de données : $e");
  //     throw e;
  //   }
  // }
  static Future<Uint8List> exportDatabase() async {
    try {
      DossierService dossierService = new DossierService();
      // Utiliser votre service pour récupérer les dossiers avec les historiques
      List<Dossier> dossiersWithHistoriques =
          await dossierService.getAllDossiersWithHistoriques();
      // Convertir les dossiers avec les historiques en un format JSON
      List<Map<String, dynamic>> data = dossiersWithHistoriques
          .map((dossier) => dossier.toMapWithHistories())
          .toList();

      String jsonData = jsonEncode(data);
      // Convertir la chaîne JSON en bytes
      List<int> bytes = utf8.encode(jsonData);

      // Convertir la liste d'entiers en Uint8List
      Uint8List uint8Bytes = Uint8List.fromList(bytes);

      return uint8Bytes;
    } catch (e) {
      print("Erreur lors de l'exportation de la base de données : $e");
      throw e;
    }
  }

  // static Future<void> importerDatabase(File importFile) async {
  //   try {
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String dbPath = join(appDocDir.path, _dbName);

  //     if (await importFile.exists()) {
  //       // Supprimez l'ancienne base de données s'il en existe une
  //       await DossierRepository.removeDatabase(dbPath);
  //       // Copiez le fichier importé vers l'emplacement de la base de données de l'application
  //       await importFile.copy(dbPath);
  //     } else {
  //       throw Exception("Le fichier d'importation n'existe pas.");
  //     }
  //   } catch (e) {
  //     print("Erreur lors de l'importation de la base de données : $e");
  //     throw e;
  //   }
  // }
  //
  //
  static Future<void> importDatabase(File importFile) async {
    try {
      DossierService dossierService = new DossierService();
      String jsonData = await importFile.readAsString();
      List<dynamic> data = jsonDecode(jsonData);

      for (dynamic item in data) {
        List<dynamic> historiquesData = item['historiques'];

        int? dossierId = await _insertDossier(item, dossierService);

        for (dynamic historiqueData in historiquesData) {
          await _insertHistorique(historiqueData, dossierId!, dossierService);
        }
      }
    } catch (e) {
      print("Erreur lors de l'importation de la base de données : $e");
      throw e;
    }
  }

  static Future<int?> _insertDossier(
      Map<String, dynamic> dossierData, DossierService dossierService) async {
    // Supprimer l'ID du dossier pour éviter les conflits
    dossierData.remove('id');
    dossierData.remove('historiques');

    // Vérifier si un dossier avec le même numéro existe déjà
    Dossier? existingDossier = await dossierService
        .getDossierByNumero(dossierData['numero'].toString());
    if (existingDossier == null) {
      int newDossierId =
          await dossierService.saveDossierSimple(Dossier.fromMap(dossierData));
      return newDossierId;
    } else {
      return existingDossier.id;
    }
  }

  static Future<void> _insertHistorique(Map<String, dynamic> historiqueData,
      int dossierId, DossierService dossierService) async {
    // Supprimer l'ID de l'historique pour éviter les conflits
    historiqueData.remove('id');
    // Mettre à jour l'ID du dossier
    historiqueData['idDossier'] = dossierId;

    // Vérifier si l'historique existe déjà
    bool historiqueExists = await dossierService.checkHistoriqueExist(
        historiqueData['statut'], historiqueData['date'], dossierId);
    if (!historiqueExists) {
      await dossierService.saveHistorique(Historique.fromMap(historiqueData));
    }
  }
}
