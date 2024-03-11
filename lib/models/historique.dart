import 'dart:convert';

import 'package:gestiondossier/models/dossier.dart';

class Historique {
  int? id = 1;
  int? idDossier = 1;
  String? utilisateur;
  String? sigle;
  DateTime? date;
  Statut? statut;
  String? observation;

  Historique({
    this.id,
    this.idDossier,
    this.utilisateur,
    this.sigle,
    this.date,
    this.statut,
    this.observation,
  });

  String getDescription() {
    if (statut == Statut.Rendu) return "Retour";
    if (statut == Statut.Arrive) return "Arrivée";
    return "Prise";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idDossier': idDossier,
      'utilisateur': utilisateur,
      'sigle': sigle,
      'date': date?.millisecondsSinceEpoch,
      'observation': observation,
      'statut': statut?.index,
    };
  }

  factory Historique.fromMap(Map<String, dynamic> map) {
    return Historique(
      id: map['id'],
      idDossier: map['idDossier'],
      utilisateur: map['utilisateur'],
      sigle: map['sigle'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      observation: map['observation'],
      statut: Statut.values[int.parse(map['statut'])],
    );
  }

  String toJson() => json.encode(toMap());
}
