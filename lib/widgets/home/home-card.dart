import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gestiondossier/screens/arrivee.dart';
import 'package:gestiondossier/screens/prise.dart';
import 'package:gestiondossier/screens/recherche.dart';
import 'package:gestiondossier/screens/retour.dart';
import 'package:gestiondossier/services/database_service.dart';
import 'package:gestiondossier/widgets/home/home-button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
                    await DatabaseService.exportDatabase(context);
                    // Ajoutez la logique nécessaire pour le bouton ici
                  },
                ),
                // Bouton "Import" (Upload)
                IconButton(
                  icon: Icon(Icons.cloud_upload),
                  onPressed: () {
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
}
