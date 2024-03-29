import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestiondossier/screens/arrivee.dart';
import 'package:gestiondossier/screens/prise.dart';
import 'package:gestiondossier/screens/recap.dart';
import 'package:gestiondossier/screens/recherche.dart';
import 'package:gestiondossier/screens/retour.dart';
import 'package:gestiondossier/services/database_service.dart';
import 'package:gestiondossier/widgets/home/home-button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class HomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      elevation: 4.0,
      margin: EdgeInsets.all(0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Gestion de dossier',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 32.0), // Espacement entre les lignes de boutons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: HomeButton(
                          color: Color.fromRGBO(196, 105, 26, 1),
                          text: 'Recherche',
                          icon: Icons.search,
                          pageInstance: RecherchePage(),
                        ),
                      ),
                      SizedBox(width: 16.0), // Espacement entre les boutons
                      Expanded(
                        child: HomeButton(
                          color: Colors.black,
                          text: 'Arrivée',
                          icon: Icons.save,
                          pageInstance: ArriveePage(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 32.0), // Espacement entre les lignes de boutons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: HomeButton(
                          color: Colors.black,
                          text: 'Prise',
                          icon: FontAwesomeIcons.handHolding,
                          pageInstance: PrisePage(),
                        ),
                      ),
                      SizedBox(width: 16.0), // Espacement entre les boutons
                      Expanded(
                        child: HomeButton(
                          color: Color.fromRGBO(225, 190, 100, 1),
                          text: 'Retour',
                          icon: Icons.description,
                          pageInstance: RetourPage(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 32.0), // Espacement entre les lignes de boutons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: HomeButton(
                          color: Colors.blueGrey,
                          text: 'Récaputilatif',
                          icon: Icons.dashboard,
                          pageInstance: RecapPage(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
                height:
                    8.0), // Espacement entre la dernière ligne de boutons et le bas de la Card
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Bouton "Export" (Download)
                IconButton(
                  icon: Icon(Icons.cloud_download),
                  onPressed: () async {
                    await _exportDatabase(context);
                    // Ajoutez la logique nécessaire pour le bouton ici
                  },
                ),
                // Bouton "Import" (Upload)
                IconButton(
                  icon: Icon(Icons.cloud_upload),
                  onPressed: () async {
                    await _importDatabase(context);

                    // Ajoutez la logique nécessaire pour le bouton ici
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportDatabase(BuildContext context) async {
    try {
      if (!await FlutterFileDialog.isPickDirectorySupported()) {
        print("Picking directory not supported");
        return;
      }

      Uint8List file = await DatabaseService.exportDatabase();
      // File dbFile = await DatabaseService.getDbFile();
      final pickedDirectory = await FlutterFileDialog.pickDirectory();
      String fileName = "data_dossier.json";
      if (pickedDirectory != null) {
        final filePath = await FlutterFileDialog.saveFileToDirectory(
          directory: pickedDirectory!,
          data: file,
          fileName: fileName,
          mimeType: "*/*",
          replace: true,
        );
      }

      _showDialog(
          'Export réussi',
          'La base de données a été exportée avec succès sous le fichier $fileName',
          context);
    } catch (e) {
      _showDialog(
          'Erreur d\'export',
          'Une erreur est survenue lors de l\'exportation de la base de données : $e',
          context);
    }
  }

  Future<void> _importDatabase(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null) {
        File selectedFile = File(result.files.single.path!);

        await DatabaseService.importDatabase(selectedFile);
        _showDialog('Import réussi',
            'La base de données a été importée avec succès.', context);
      }
    } catch (e) {
      _showDialog(
          'Erreur d\'import',
          'Une erreur est survenue lors de l\'importation de la base de données : $e',
          context);
    }
  }

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
