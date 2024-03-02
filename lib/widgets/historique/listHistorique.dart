import 'package:flutter/material.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:gestiondossier/widgets/historique/historique.dart';

class ListHistoriqueCard extends StatelessWidget {
  final List<Historique> historiques;

  ListHistoriqueCard({required this.historiques});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ajustez ici
          children: [
            Text(
              "Historiques :",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Afficher les cartes d'historique
            for (var historique in historiques) ...[
              HistoriqueCard(historique: historique),
              SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}
