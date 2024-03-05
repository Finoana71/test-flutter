import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/repositories/dossier_repository.dart';

class DossierService {
  late DossierRepository _repository;

  DossierService() {
    _repository = DossierRepository();
  }

  //Save Dossier
  Future<int> saveDossier(Dossier dossier) async {
    return (await _repository.insertData(dossier.toMap()))!;
  }

  //Read All Dossiers
  Future<List<Dossier>> readAllDossiers() async {
    var data = await _repository.readData();
    return data!.map((e) => Dossier.fromMap(e)).toList();
  }

  //Edit Dossier
  Future<int> updateDossier(Dossier dossier) async {
    return (await _repository.updateData(dossier.toMap()))!;
  }

  Future<int> deleteDossier(int dossierId) async {
    return (await _repository.deleteDataById(dossierId))!;
  }

  // Fonction pour obtenir la couleur en fonction du statut
  Color getColorForStatut(Statut? statut) {
    switch (statut) {
      case Statut.Arrive:
      case Statut.Rendu:
        return Colors.green;
      case Statut.Pris:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
