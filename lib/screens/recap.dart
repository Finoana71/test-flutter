import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:gestiondossier/services/dossier.dart';
import 'package:gestiondossier/services/dossier_service.dart';
import 'package:gestiondossier/services/pdf_service.dart';
import 'package:gestiondossier/widgets/historique/historiqueRecap.dart';
import 'package:zoom_widget/zoom_widget.dart';

const tableHeaderStyle = TextStyle(fontWeight: FontWeight.bold);

class RecapPage extends StatefulWidget {
  DossierService dossierService = DossierService();

  @override
  _RecapPageState createState() => _RecapPageState();
}

class _RecapPageState extends State<RecapPage> {
  late List<Dossier> dossiers;
  late PdfService _pdfService;

  @override
  void initState() {
    super.initState();
    _pdfService = PdfService();
    _fetchAllDossiersData();
  }

  void _fetchAllDossiersData() {
    widget.dossierService.getAllDossiersWithHistoriques().then((value) => {
          setState(() {
            dossiers = value;
          })
        });
  }

  Future<void> _exportToPdf() async {
    try {
      // Prepare table rows

      // Export to PDF
      final file = await _pdfService.exportToPdf(dossiers: dossiers);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: new Text("Fichier exporté sous tableau_recaputilatif.pdf"),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: new Text('Erreur, $e'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(milliseconds: 2000)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text("Tableau récapitulatif"),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: _exportToPdf,
              color: Colors.red,
            ),
          ],
        ),
        body: Zoom(
            backgroundColor: Colors.white,
            initTotalZoomOut: true,
            maxZoomWidth: MediaQuery.of(context).size.width *
                2, // Ajustez ces valeurs en fonction de vos besoins
            maxZoomHeight: MediaQuery.of(context).size.height * 2,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Tous les dossiers",
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    // textDirection: TextDirection.rtl,

                    // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                    border: TableBorder.all(width: 1.0, color: Colors.black),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Text('Dossier', style: tableHeaderStyle),
                          ),
                          TableCell(
                            child: Text('Arrivée', style: tableHeaderStyle),
                          ),
                          TableCell(
                            child: Text('Prises', style: tableHeaderStyle),
                          ),
                          TableCell(
                            child: Text('Retours', style: tableHeaderStyle),
                          ),
                        ],
                      ),
                      for (var dossier in dossiers)
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '${dossier.numero} - ${dossier.getStatut()}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: ListHistoriqueRecap(dossier
                                    .getHistoriquesByStatut(Statut.Arrive)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: ListHistoriqueRecap(dossier
                                    .getHistoriquesByStatut(Statut.Pris)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: ListHistoriqueRecap(dossier
                                    .getHistoriquesByStatut(Statut.Rendu)),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
