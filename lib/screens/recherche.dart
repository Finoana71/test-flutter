import 'package:flutter/material.dart';
import 'package:gestiondossier/helpers/dossierDatabase.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/services/dossier.dart';
import 'package:gestiondossier/widgets/listCard.dart';
import 'package:gestiondossier/widgets/search-bar.dart';

class RecherchePage extends StatefulWidget {
  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  DossierService dossierService = DossierService();

  List<Dossier> listeDossiers = [];

  @override
  void initState() {
    super.initState();
    // Appel asynchrone à getListDossiers lors de l'initialisation du widget
    refreshDossiers();
  }

  @override
  dispose() {
    //close the database
    // dossierService.dossierDatabase.close();
    super.dispose();
  }

  refreshDossiers() {
    dossierService.getListDossiers().then((value) {
      setState(() {
        listeDossiers = value;
      });
    });
  }
  // Future<void> _loadDossiers() async {
  //   List<Dossier> dossiers = await dossierService.getListDossiers();
  //   setState(() {
  //     listeDossiers = dossiers;
  //   });
  //   print("sss2");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
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
