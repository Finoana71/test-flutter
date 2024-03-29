import 'package:gestiondossier/helpers/fields/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'dart:convert';

enum Statut { Arrive, Pris, Rendu }

class Dossier {
  int? id = 1;
  String? numero;
  String? utilisateur;
  String? sigle;
  DateTime? date;
  String? observation;
  Statut? statut;
  List<Historique> historiques = [];

  Dossier({
    this.id,
    this.numero,
    this.utilisateur,
    this.sigle,
    this.date,
    this.observation,
    this.statut,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numero': numero,
      'utilisateur': utilisateur,
      'sigle': sigle,
      'date': date?.millisecondsSinceEpoch,
      'observation': observation,
      'statut': statut?.index,
    };
  }

  Map<String, dynamic> toMapWithHistories() {
    return {
      'id': id,
      'numero': numero,
      'utilisateur': utilisateur,
      'sigle': sigle,
      'date': date?.millisecondsSinceEpoch,
      'observation': observation,
      'statut': statut?.index,
      'historiques': Historique.historiquesListToMap(historiques)
    };
  }

  String getStatut() {
    if (this.statut == Statut.Pris) return "Pris";
    if (this.statut == Statut.Rendu) return "Rendu";
    return "Arrivée";
  }

  Dossier copyWith({
    int? id,
    String? numero,
    String? utilisateur,
    String? sigle,
    DateTime? date,
    String? observation,
    Statut? statut,
  }) {
    return Dossier(
        id: id ?? this.id,
        numero: numero ?? this.numero,
        utilisateur: utilisateur ?? this.utilisateur,
        sigle: sigle ?? this.sigle,
        date: date ?? this.date,
        observation: observation ?? this.observation,
        statut: statut ?? this.statut);
  }

  factory Dossier.fromMap(Map<String, dynamic> map) {
    return Dossier(
      id: map['id'] ?? null,
      numero: map['numero'],
      utilisateur: map['utilisateur'],
      sigle: map['sigle'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      observation: map['observation'],
      statut: Statut.values[int.parse(map['statut'].toString())],
    );
  }

  String toJson() {
    Map<String, dynamic> map = toMap();
    map["historiques"] = Historique.historiquesListToMap(historiques);
    return json.encode(map);
  }

  factory Dossier.fromJson(Map<String, Object?> json) {
    Dossier dossier = Dossier(
      id: json['id'] as int?,
      numero: json['numero'] as String,
      utilisateur: json['utilisateur'] as String,
      sigle: json['sigle'] as String,
      date:
          DateTime.fromMillisecondsSinceEpoch(json[DossierFields.date] as int),
      observation: json['observation'] as String,
      statut: json['statut'] as Statut,
    );
    dossier.historiques =
        Historique.historiquesListFromJson(json['historiques'] as String);
    return dossier;
  }

  Dossier copy({
    int? id,
    String? numero,
    String? utilisateur,
    String? sigle,
    DateTime? date,
    String? observation,
    Statut? statut,
  }) =>
      Dossier(
        id: id ?? this.id,
        numero: numero ?? this.numero,
        utilisateur: utilisateur ?? this.utilisateur,
        sigle: sigle ?? this.sigle,
        date: date ?? this.date,
        observation: observation ?? this.observation,
        statut: statut ?? this.statut,
      );
  Historique generateFirstHistory(int id) {
    return new Historique(
        idDossier: id,
        utilisateur: utilisateur,
        sigle: sigle,
        date: date!,
        statut: statut,
        observation: observation);
  }

  Historique generateHistory(String utilisateur, String sigle,
      String observation, DateTime date, Statut statut) {
    return new Historique(
        idDossier: this.id,
        utilisateur: utilisateur,
        sigle: sigle,
        date: date,
        statut: statut,
        observation: observation);
  }

  List<Historique> getHistoriquesByStatut(Statut statut) {
    return historiques.where((element) => element.statut == statut).toList();
  }
}
