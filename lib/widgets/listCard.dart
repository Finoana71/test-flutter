import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/screens/detail.dart';
import 'package:gestiondossier/screens/formPrise.dart';
import 'package:gestiondossier/screens/formRetour.dart';
import 'package:gestiondossier/services/dossier_service.dart';

class ListCard extends StatelessWidget {
  final Dossier dossier;

  ListCard({required this.dossier});
  DossierService dossierService = DossierService();

  @override
  Widget build(BuildContext context) {
    String actionButtonLabel = "";
    Function()? actionButtonFunction;
    Color buttonColor = Colors.blue; // Couleur par défaut

    // Déterminez le libellé, la fonction et la couleur du bouton en fonction du statut du dossier
    switch (dossier.statut) {
      case Statut.Arrive:
      case Statut.Rendu:
        actionButtonLabel = "Prise";
        actionButtonFunction = () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPrisePage(dossier: dossier),
            ),
          );
        };
        buttonColor = Colors.green; // Couleur pour le statut Arrivé ou Rendu
        break;
      case Statut.Pris:
        actionButtonLabel = "Retour";
        actionButtonFunction = () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormRetourPage(dossier: dossier),
            ),
          );
        };
        buttonColor = Colors.blue; // Couleur pour le statut Pris
        break;
      default:
        break;
    }

    return InkWell(
      onTap: () {
        // Naviguer vers la page de détail du dossier lorsqu'on clique sur la card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailDossierPage(dossier: dossier),
          ),
        );
      },
      child: Card(
        // Mise en forme de la carte selon vos besoins
        child: ListTile(
          title: Text("Dossier ${dossier.numero}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${dossier.utilisateur} - ${dossier.date?.toLocal().toLocal().toString().split(' ')[0]}"),
              Chip(
                label: Text(
                  "${dossier.getStatut()}",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor:
                    dossierService.getColorForStatut(dossier.statut),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: actionButtonFunction,
                child: Text(actionButtonLabel),
                style: ElevatedButton.styleFrom(
                  primary: buttonColor, // Définir la couleur du bouton
                ),
              ),
              SizedBox(width: 8), // Espacement entre les boutons
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Mettez ici la logique pour supprimer le dossier
                  // Par exemple, un appel à une fonction de service ou de gestion des données
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
