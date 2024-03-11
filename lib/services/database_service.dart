import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:file_saver/file_saver.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Future<void> exportDatabase(BuildContext context) async {
    print('Exportation');
    try {
      // Obtenez le chemin de la base de données actuelle
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'db_dossiers');

      // Laissez l'utilisateur choisir le répertoire où sauvegarder la base de données
      FilePickerCross myFile = await FilePickerCross.importFromStorage(
          type: FileTypeCross.custom, fileExtension: 'sqlite');
      if (myFile != null && myFile.toBase64() != null) {
        // Obtenez le chemin choisi par l'utilisateur
        String? downloadPath = myFile.fileName;

        // Copiez la base de données vers l'emplacement choisi par l'utilisateur
        await File(path).copy(downloadPath!);

        // Faites quelque chose avec le chemin, par exemple, imprimez-le
        print('Base de données copiée avec succès à : $downloadPath');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Exportation réussie'),
          backgroundColor: Colors.green,
        ));
      } else {
        // L'utilisateur a annulé le choix du répertoire
        print('Exportation annulée par l\'utilisateur.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Erreur lors de l\'exportation de la base de données : $e'),
        backgroundColor: Colors.redAccent,
      ));
      print('Erreur lors de l\'exportation de la base de données : $e');
    }
  }
}
