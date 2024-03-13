import 'package:flutter/material.dart';
import 'package:gestiondossier/models/historique.dart';

const snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
);

class HistoriqueCard extends StatelessWidget {
  final Historique historique;

  HistoriqueCard({required this.historique});

  TextStyle labelStyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle contentStyle() {
    return TextStyle(
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Date :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${historique.date?.toLocal().toString().split(' ')[0]}",
                    style: contentStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Utilisateur :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${historique.utilisateur}",
                    style: contentStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Description :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${historique.getDescription()}",
                    style: contentStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Sigle :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${historique.sigle}",
                    style: contentStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Observation :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${historique.observation}",
                    style: contentStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
