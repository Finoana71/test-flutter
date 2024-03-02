import 'package:gestiondossier/models/dossier.dart';

class Historique {
  int? id = 1;
  int? idDossier = 1;
  final String utilisateur;
  final String sigle;
  final DateTime date;
  final Statut statut;
  final String observation;

  Historique({
    this.id,
    required this.idDossier,
    required this.utilisateur,
    required this.sigle,
    required this.date,
    required this.statut,
    required this.observation,
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
      'date': date.millisecondsSinceEpoch,
      'observation': observation,
      'statut': statut,
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
      statut: map['statut'],
    );
  }
}
