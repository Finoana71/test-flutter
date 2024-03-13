import 'dart:io';
import 'package:gestiondossier/repositories/dossier_repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static const String _dbName = 'db_dossiers';

  static Future<void> exporterDatabase(
      String exportPath, String exportFileName) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String dbPath = join(appDocDir.path, _dbName);

      File originalFile = File(dbPath);

      if (originalFile.existsSync()) {
        String exportFilePath = join(exportPath, exportFileName);

        // Copier le fichier original vers le nouvel emplacement avec le nouveau nom
        await originalFile.copy(exportFilePath);
      } else {
        throw Exception("La base de données d'origine n'existe pas.");
      }
    } catch (e) {
      print("Erreur lors de l'exportation de la base de données : $e");
      throw e;
    }
  }

  static Future<File> getDbFile() async {
    try {
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
        // Remplacer la base de données d'origine par le fichier importé
        await importFile.copy(dbPath);
        DossierRepository.removeDatabase();
      } else {
        throw Exception("Le fichier d'importation n'existe pas.");
      }
    } catch (e) {
      print("Erreur lors de l'importation de la base de données : $e");
      throw e;
    }
  }
}
