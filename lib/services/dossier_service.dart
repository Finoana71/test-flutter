import 'package:flutter/material.dart';
import 'package:gestiondossier/helpers/dossierDatabase.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:gestiondossier/repositories/dossier_repository.dart';

class DossierService {
  late DossierRepository _repository;

  DossierService() {
    _repository = DossierRepository();
  }

  //Save Dossier
  Future<int> saveDossier(Dossier dossier) async {
    var dossiers = await _repository.readDataByNumero(dossier.numero!);
    if (dossiers!.isNotEmpty) {
      throw new Exception("Un dossier comportant ce numéro existe déjà");
    }
    int dossierId = (await _repository.insertData(dossier.toMap(), null))!;
    Historique historique = dossier.generateFirstHistory(dossierId);
    await saveHistorique(historique);
    return dossierId;
  }

  Future<void> saveHistorique(Historique historique) async {
    (await _repository.insertData(historique.toMap(), tableHistorique))!;
  }

  // Mise à jour statut dossier avec historique
  Future<void> updateStatutDossier(
      Dossier dossier,
      Statut statut,
      String utilisateur,
      String sigle,
      String observation,
      DateTime date) async {
    // Créez l'historique
    Historique historique =
        dossier.generateHistory(utilisateur, sigle, observation, date, statut);
    await saveHistorique(historique);
    dossier.statut = statut;
    await updateDossier(dossier);
  }

  //Read All Dossiers
  Future<List<Dossier>> readAllDossiers(String search) async {
    search = '%$search%';
    const where = 'numero LIKE ?';
    List args = [search];
    var data = await _repository.readData(search, where, args);
    return data!.map((e) => Dossier.fromMap(e)).toList();
  }

  //Read All Dossiers
  Future<List<Dossier>> readAllDossiersStatut(
      String search, List<Statut> statuts) async {
    search = '%$search%';
    Iterable<int> statutNumbers = statuts.map((e) => e.index);
    String where =
        'statut IN (${statutNumbers.map((statut) => '?').join(', ')}) AND numero LIKE ?';
    List args = [...statutNumbers, search];
    var data = await _repository.readData(search, where, args);
    return data!.map((e) => Dossier.fromMap(e)).toList();
  }

  //Edit Dossier
  Future<int> updateDossier(Dossier dossier) async {
    return (await _repository.updateData(dossier.toMap()))!;
  }

  Future<int> deleteDossier(int dossierId) async {
    return (await _repository.deleteDataById(dossierId))!;
  }

  Future<List<Historique>> getHistoriqueDossiers(int idDossier) async {
    String where = "idDossier = ?";
    List args = [idDossier];
    var data = await _repository.readAllData(tableHistorique, where, args);
    return data!.map((e) => Historique.fromMap(e)).toList();
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
