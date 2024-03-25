import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class PdfService {
  Future<Uint8List> generatePdfBytes(List<pw.TableRow> tableRows) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Tableau récapitulatif",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.SizedBox(height: 20),
              ],
            ),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FractionColumnWidth(0.2),
                1: pw.FractionColumnWidth(0.26),
                2: pw.FractionColumnWidth(0.27),
                3: pw.FractionColumnWidth(0.27),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text("Dossier",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Arrivée",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Prises",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Retours",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                ...tableRows
              ],
            )
          ];
        },
      ),
    );

    return pdf.save();
  }

  Future<void> exportToPdf({required List<Dossier> dossiers}) async {
    // Create table rows
    final List<pw.TableRow> tableRows = _generateTableRows(dossiers);

    // Generate PDF bytes
    final Uint8List pdfBytes = await generatePdfBytes(tableRows);

    // Ask user for directory to save the PDF file
    final pickedDirectory = await FlutterFileDialog.pickDirectory();
    String fileName = "tableau_recaputilatif.pdf";
    if (pickedDirectory != null) {
      final filePath = await FlutterFileDialog.saveFileToDirectory(
        directory: pickedDirectory,
        data: pdfBytes,
        fileName: fileName,
        mimeType: "application/pdf",
        replace: true,
      );
    }
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
                    style: pw.TextStyle(fontSize: 12),
                  ),
                  pw.SizedBox(height: 3.0),
                  pw.Text(
                    'par ${historique.utilisateur}',
                    style: pw.TextStyle(fontSize: 10),
                  ),
                  pw.SizedBox(height: 8.0),
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
