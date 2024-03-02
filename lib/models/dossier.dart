import 'package:gestiondossier/helpers/fields/dossier.dart';
import 'package:gestiondossier/models/historique.dart';

enum Statut { Arrive, Pris, Rendu }

class Dossier {
  int? id = 1;
  final String numero;
  final String utilisateur;
  final String sigle;
  final DateTime? date;
  final String observation;
  Statut statut;
  List<Historique> historiques = [];

  Dossier({
    this.id,
    required this.numero,
    required this.utilisateur,
    required this.sigle,
    required this.date,
    required this.observation,
    required this.statut,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numero': numero,
      'utilisateur': utilisateur,
      'sigle': sigle,
      'date': date?.millisecondsSinceEpoch,
      'observation': observation,
      'statut': statut,
    };
  }

  String getStatut() {
    if (this.statut == Statut.Pris) return "Pris";
    if (this.statut == Statut.Rendu) return "Rendu";
    return "Arrivée";
  }

  factory Dossier.fromMap(Map<String, dynamic> map) {
    return Dossier(
      id: map['id'],
      numero: map['numero'],
      utilisateur: map['utilisateur'],
      sigle: map['sigle'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      observation: map['observation'],
      statut: map['statut'],
    );
  }

  factory Dossier.fromJson(Map<String, Object?> json) {
    return Dossier(
      id: json['id'] as int?,
      numero: json['numero'] as String,
      utilisateur: json['utilisateur'] as String,
      sigle: json['sigle'] as String,
      date: DateTime.tryParse(json[DossierFields.date] as String? ?? ''),
      observation: json['observation'] as String,
      statut: json['statut'] as Statut,
    );
  }

  Map<String, Object?> toJson() => {
        DossierFields.id: id,
        DossierFields.numero: numero,
        DossierFields.utilisateur: utilisateur,
        DossierFields.sigle: sigle,
        DossierFields.date: date?.toIso8601String(),
        DossierFields.observation: observation,
        DossierFields.statut: statut,
      };

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
}
