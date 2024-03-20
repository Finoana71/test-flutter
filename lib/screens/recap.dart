import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:gestiondossier/services/dossier.dart';
import 'package:gestiondossier/services/dossier_service.dart';
import 'package:gestiondossier/widgets/historique/historiqueRecap.dart';
import 'package:zoom_widget/zoom_widget.dart';

class RecapPage extends StatefulWidget {
  DossierService dossierService = DossierService();

  @override
  _RecapPageState createState() => _RecapPageState();
}

class _RecapPageState extends State<RecapPage> {
  late List<Dossier> dossiers;

  @override
  void initState() {
    super.initState();
    _fetchAllDossiersData();
  }

  void _fetchAllDossiersData() {
    widget.dossierService.getAllDossiersWithHistoriques().then((value) => {
          setState(() {
            dossiers = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tableau récapitulatif"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Zoom(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(
                    1), // La première colonne occupe 1/3 de l'espace disponible
                1: FlexColumnWidth(1), // Les colonnes suivantes également
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Dossier'),
                    ),
                    TableCell(
                      child: Text('Arrivée'),
                    ),
                    TableCell(
                      child: Text('Prises'),
                    ),
                    TableCell(
                      child: Text('Retours'),
                    ),
                  ],
                ),
                // for (var dossier in dossiers)
                //   TableRow(
                //     children: [
                //       TableCell(
                //         child: Container(
                //           padding: EdgeInsets.all(8.0),
                //           child: Text(
                //             '${dossier.numero} - ${dossier.getStatut()}',
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //       TableCell(
                //         child: Container(
                //           padding: EdgeInsets.all(8.0),
                //           child: ListHistoriqueRecap(
                //               dossier.getHistoriquesByStatut(Statut.Arrive)),
                //         ),
                //       ),
                //       TableCell(
                //         child: Container(
                //           padding: EdgeInsets.all(8.0),
                //           child: ListHistoriqueRecap(
                //               dossier.getHistoriquesByStatut(Statut.Pris)),
                //         ),
                //       ),
                //       TableCell(
                //         child: Container(
                //           padding: EdgeInsets.all(8.0),
                //           child: ListHistoriqueRecap(
                //               dossier.getHistoriquesByStatut(Statut.Rendu)),
                //         ),
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
