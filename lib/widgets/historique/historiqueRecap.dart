import 'package:flutter/material.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:intl/intl.dart';

class ListHistoriqueRecap extends StatelessWidget {
  final List<Historique> historiques;

  ListHistoriqueRecap(this.historiques);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: historiques.map((historique) {
        return Container(
          margin: EdgeInsets.only(bottom: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd-MM-yyyy').format(historique.date!),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                'par ${historique.utilisateur}',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
