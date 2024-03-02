import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/screens/retour.dart';
import 'package:gestiondossier/widgets/search-bar.dart';

class PrisePage extends RetourPage {
  String title = "Prise";
  List<Statut> statutsRecherches = [Statut.Rendu, Statut.Arrive];
}
