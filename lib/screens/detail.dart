import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/services/dossier.dart';
import 'package:gestiondossier/widgets/historique/listHistorique.dart';

class DetailDossierPage extends StatelessWidget {
  final Dossier dossier;
  DossierService dossierService = DossierService();

  DetailDossierPage({required this.dossier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détail du Dossier ${dossier.numero}"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Numéro : ${dossier.numero}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Utilisateur : ${dossier.utilisateur}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Sigle : ${dossier.sigle}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Date d'arrivée: ${dossier.date!.toLocal().toString().split(' ')[0]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Chip(
                      label: Text(
                        "${dossier.getStatut()}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor:
                          dossierService.getColorForStatut(dossier.statut),
                    ),
                  ],
                ),
              ),
            ),
            ListHistoriqueCard(
              historiques: dossier.historiques,
            ),
          ],
        ),
      ),
    );
  }
}
