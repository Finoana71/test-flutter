import 'dart:io';

import 'package:gestiondossier/repositories/dossier_repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static const String _dbName = 'db_dossiers';

  static Future<File> getDbFile() async {
    try {
      // Fermer la base de données avant l'exportation
      await DossierRepository.closeDatabase();

      // Attendre un court instant pour permettre la fermeture de la base de données
      await Future.delayed(Duration(milliseconds: 500));

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String dbPath = join(appDocDir.path, _dbName);
      File originalFile = File(dbPath);

      if (originalFile.existsSync()) {
        return originalFile;
      } else {
        throw Exception("La base de données d'origine n'existe pas.");
      }
    } catch (e) {
      print("Erreur lors de l'exportation de la base de données : $e");
      throw e;
    }
  }

  static Future<void> importerDatabase(File importFile) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String dbPath = join(appDocDir.path, _dbName);

      if (await importFile.exists()) {
        // Supprimez l'ancienne base de données s'il en existe une
        await DossierRepository.removeDatabase(dbPath);
        // Copiez le fichier importé vers l'emplacement de la base de données de l'application
        await importFile.copy(dbPath);
      } else {
        throw Exception("Le fichier d'importation n'existe pas.");
      }
    } catch (e) {
      print("Erreur lors de l'importation de la base de données : $e");
      throw e;
    }
  }
}
