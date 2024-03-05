import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/services/dossier.dart';
import 'package:gestiondossier/services/dossier_service.dart';
import 'package:gestiondossier/widgets/listCard.dart';
import 'package:gestiondossier/widgets/search-bar.dart';

class RetourPage extends StatefulWidget {
  @override
  _RetourPageState createState() => _RetourPageState();
}

class _RetourPageState extends State<RetourPage> {
  DossierService dossierService = DossierService();
  List<Statut> statutsRecherches = [Statut.Pris];
  String title = "Retour";
  List<Dossier> listeDossiers = [];

  @override
  void initState() {
    super.initState();
    // Appel asynchrone à getDossiersByStatuts lors de l'initialisation du widget
    _loadDossiers();
  }

  Future<void> _loadDossiers() async {
    List<Dossier> dossiers = await dossierService.readAllDossiers();
    // await dossierService.getDossiersByStatuts(statutsRecherches);
    setState(() {
      listeDossiers = dossiers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 6.0,
          ),
          MySearchBar(),
          SizedBox(
            height: 16.0,
          ),
          // Affichez la liste des dossiers ici
          Expanded(
            child: ListView.builder(
              itemCount: listeDossiers.length,
              itemBuilder: (context, index) {
                Dossier dossier = listeDossiers[index];
                return ListCard(dossier: dossier);
              },
            ),
          ),
        ],
      ),
    );
  }
}
