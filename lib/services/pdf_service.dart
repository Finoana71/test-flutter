import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class PdfService {
  Future<File?> exportToPdf({required List<Dossier> dossiers}) async {
    // Create table rows
    final List<pw.TableRow> tableRows = _generateTableRows(dossiers);

    // Create a PDF document
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table(
            children: tableRows,
          );
        },
      ),
    );

    // Ask user for file name and location
    final params = SaveFileDialogParams(sourceFilePath: null);
    final path = await FlutterFileDialog.saveFile(params: params);

    if (path == null) {
      throw Exception('No file selected');
    }

    // Save the PDF file
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  List<pw.TableRow> _generateTableRows(List<Dossier> dossiers) {
    return dossiers.map((dossier) {
      // Create a list of widgets for each cell in the table row
      List<pw.Widget> cells = [
        pw.Container(
          padding: pw.EdgeInsets.all(8.0),
          child: pw.Text(
            '${dossier.numero} - ${dossier.getStatut()}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
      ];

      // Add historiques for Arrivée, Prises, and Retours
      for (var statut in [Statut.Arrive, Statut.Pris, Statut.Rendu]) {
        List<Historique> historiques = dossier.getHistoriquesByStatut(statut);
        cells.add(pw.Container(
          padding: pw.EdgeInsets.all(8.0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: historiques.map((historique) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    DateFormat('dd-MM-yyyy').format(historique.date!),
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.SizedBox(height: 4.0),
                  pw.Text(
                    'par ${historique.utilisateur}',
                    style: pw.TextStyle(fontSize: 14),
                  ),
                ],
              );
            }).toList(),
          ),
        ));
      }

      // Create TableRow from cells
      return pw.TableRow(children: cells);
    }).toList();
  }
}

// Le reste du code reste le même...
