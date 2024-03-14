import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:gestiondossier/services/dossier.dart';
import 'package:gestiondossier/services/dossier_service.dart';
import 'package:gestiondossier/widgets/historique/listHistorique.dart';

class DetailDossierPage extends StatefulWidget {
  final Dossier dossier;
  DossierService dossierService = DossierService();

  DetailDossierPage({required this.dossier});

  @override
  _DetailDossierPageState createState() => _DetailDossierPageState();
}

class _DetailDossierPageState extends State<DetailDossierPage> {
  late List<Historique> historiques;

  @override
  void initState() {
    super.initState();
    _fetchHistoriqueData();
  }

  void _fetchHistoriqueData() {
    widget.dossierService
        .getHistoriqueDossiers(widget.dossier.id!)
        .then((value) => {
              setState(() {
                historiques = value;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détail du Dossier ${widget.dossier.numero}"),
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
                child: Wrap(
                  // Utilisation de Wrap pour gérer le débordement de texte
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    Text(
                      "Numéro : ${widget.dossier.numero}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Utilisateur : ${widget.dossier.utilisateur}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Sigle : ${widget.dossier.sigle}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Date d'arrivée: ${widget.dossier.date!.toLocal().toString().split(' ')[0]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Chip(
                      label: Text(
                        "${widget.dossier.getStatut()}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: widget.dossierService
                          .getColorForStatut(widget.dossier.statut),
                    ),
                  ],
                ),
              ),
            ),
            // Afficher l'historique
            if (historiques.isNotEmpty)
              ListHistoriqueCard(
                historiques: historiques,
              )
            else
              Text('Aucun historique disponible.'),
          ],
        ),
      ),
    );
  }
}
