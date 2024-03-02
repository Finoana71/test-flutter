import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestiondossier/helpers/database.dart';
import 'package:gestiondossier/helpers/dossierDatabase.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:gestiondossier/services/sqlite_service.dart';

final String tableTodo = 'todo';

class DossierService {
  // static List<Dossier> _listDossiers = [
  //   Dossier(
  //       numero: "00011",
  //       utilisateur: "Rakoto",
  //       sigle: "04545",
  //       date: DateTime.now(),
  //       statut: Statut.Arrive,
  //       observation: "--"),
  //   Dossier(
  //       numero: "000532",
  //       utilisateur: "Rabe",
  //       sigle: "04545",
  //       date: DateTime.now(),
  //       statut: Statut.Pris,
  //       observation: "--"),
  //   // Ajoutez d'autres dossiers par défaut au besoin
  // ];

  // List<Dossier> get listDossiers => _listDossiers;

  // List<Dossier> getDossiersByStatuts(List<Statut> statuts) {
  //   List<Dossier> filteredDossiers = _listDossiers
  //       .where((dossier) => statuts.contains(dossier.statut))
  //       .toList();
  //   print(statuts.length);
  //   return filteredDossiers;
  // }

  // // Méthode pour ajouter un dossier à la liste
  // void addDossier(Dossier dossier) {
  //   Historique historique = new Historique(
  //       idDossier: 1,
  //       utilisateur: dossier.utilisateur,
  //       sigle: dossier.sigle,
  //       date: dossier.date,
  //       observation: dossier.observation,
  //       statut: Statut.Arrive);
  //   dossier.historiques.add(historique);
  //   _listDossiers.add(dossier);
  // }

  // // Méthode pour obtenir la liste actuelle des dossiers
  // List<Dossier> getListDossiers() {
  //   return List.from(_listDossiers);
  // }w
  // final DatabaseHelper _databaseHelper = DatabaseHelper();
  final SqliteService _sqliteService = new SqliteService();
  // DossierDatabase dossierDatabase = DossierDatabase.instance;

  // Méthode pour ajouter un dossier à la base de données
  Future<void> addDossier(Dossier dossier) async {
    await _sqliteService.insertDossier(dossier);
    // await dossierDatabase.createDossier(dossier);
  }

  // Méthode pour obtenir la liste actuelle des dossiers
  Future<List<Dossier>> getListDossiers() async {
    // return await dossierDatabase.listDossier();
    return await _sqliteService.getDossiers();
  }

  // Fonction pour obtenir la couleur en fonction du statut
  Color getColorForStatut(Statut statut) {
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
