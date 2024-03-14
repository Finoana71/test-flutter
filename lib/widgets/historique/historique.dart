import 'package:flutter/material.dart';
import 'package:gestiondossier/models/historique.dart';

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
      overflow: TextOverflow.clip,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Row(
              children: [
                Text(
                  "Date :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Text(
                  "${historique.date?.toLocal().toString().split(' ')[0]}",
                  style: contentStyle(),
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
                Text(
                  "${historique.utilisateur}",
                  style: contentStyle(),
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
                Text(
                  "${historique.getDescription()}",
                  style: contentStyle(),
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
                Text(
                  "${historique.sigle}",
                  style: contentStyle(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Observation :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Text(
                  "${historique.observation}",
                  style: contentStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
