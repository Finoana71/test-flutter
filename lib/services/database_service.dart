import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Future<void> exportDatabase() async {
    try {
      // Obtenez le chemin de la base de données actuelle
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'db_dossiers');

      // Laissez l'utilisateur choisir l'emplacement et le nom du fichier
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );

      if (result != null) {
        // Obtenez le chemin choisi par l'utilisateur
        String downloadPath = result.files.single.path!;

        // Copiez la base de données vers l'emplacement choisi par l'utilisateur
        await File(path).copy(downloadPath);

        // Faites quelque chose avec le chemin, par exemple, imprimez-le
        print('Base de données copiée avec succès à : $downloadPath');

        print('Exportation réussie');
      } else {
        // L'utilisateur a annulé le choix du fichier
        print('Exportation annulée par l\'utilisateur.');
      }
    } catch (e) {
      print('Erreur lors de l\'exportation de la base de données : $e');
    }
  }
}
