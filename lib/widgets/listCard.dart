import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/screens/detail.dart';
import 'package:gestiondossier/screens/formPrise.dart';
import 'package:gestiondossier/screens/formRetour.dart';
import 'package:gestiondossier/services/dossier_service.dart';

class ListCard extends StatelessWidget {
  final Dossier dossier;
  final int index; // Ajoutez cet attribut
  final Function(int) onDelete; // Ajoutez cet attribut

  ListCard(
      {required this.dossier, required this.index, required this.onDelete});

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
          title: Text(
            "Dossier ${dossier.numero}",
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${dossier.utilisateur} - ${dossier.date?.toLocal().toLocal().toString().split(' ')[0]}",
                overflow: TextOverflow.ellipsis,
              ),
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
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: actionButtonFunction,
                child: Text(actionButtonLabel),
                style: ElevatedButton.styleFrom(
                  primary: buttonColor, // Définir la couleur du bouton
                ),
              ),
              SizedBox(height: 8), // Espacement entre les boutons
              ElevatedButton(
                onPressed: () {
                  delete(context);
                },
                child: Text("Supprimer"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Définir la couleur du bouton
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmer la suppression"),
            content: Text("Voulez-vous vraiment supprimer ce dossier ?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Fermer la boîte de dialogue
                },
                child: Text("Annuler"),
              ),
              TextButton(
                onPressed: () {
                  dossierService
                      .deleteDossier(dossier.id!)
                      .then((value) => {onSuccessDelete(context)})
                      .catchError((err) => {onErrorDelete(err, context)});
                },
                child: Text("Supprimer"),
              ),
            ],
          );
        });
  }

  void onSuccessDelete(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Dossier supprimé'),
      backgroundColor: Colors.lightBlue,
    ));
    onDelete(index);
    Navigator.pop(context); // Fermer la boîte de dialogue
  }

  void onErrorDelete(String err, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Erreur, $err'),
      backgroundColor: Colors.red,
    ));
    onDelete(index);
  }
}
