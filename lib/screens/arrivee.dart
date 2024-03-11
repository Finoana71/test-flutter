import 'package:flutter/material.dart';
import 'package:gestiondossier/helpers/snackbar_helper.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/screens/recherche.dart';
import 'package:gestiondossier/services/dossier.dart';
import 'package:gestiondossier/services/dossier_service.dart';
import 'package:gestiondossier/widgets/my-button.dart';
import 'package:get/get.dart';

class ArriveePage extends StatefulWidget {
  @override
  _ArriveePageState createState() => _ArriveePageState();
}

class _ArriveePageState extends State<ArriveePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _utilisateurController = TextEditingController();
  TextEditingController _sigleController = TextEditingController();
  TextEditingController _observationController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DossierService dossierService = new DossierService();
  SnackBarHelper snackBarHelper = new SnackBarHelper();
  BuildContext? context2;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context2 = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Arrivee'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _numeroController,
                decoration: InputDecoration(labelText: 'Numéro'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le numéro du dossier';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _utilisateurController,
                decoration: InputDecoration(labelText: 'Utilisateur'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Veuillez entrer l'utilisateur";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _sigleController,
                decoration: InputDecoration(labelText: 'Sigle'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le sigle';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _observationController,
                maxLines: 4, // Définissez le nombre de lignes souhaité
                decoration: InputDecoration(labelText: 'Observation'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer une observation';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date : ${_selectedDate.toLocal().toLocal().toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              MyButton(text: 'Enregistrer', onPressed: addDossier),
            ],
          ),
        ),
      ),
    );
  }

  void addDossier() {
    if (_formKey.currentState!.validate()) {
      // Traitez les données du formulaire ici
      String utilisateur = _utilisateurController.text;
      String sigle = _sigleController.text;
      String numero = _numeroController.text;
      String observation = _observationController.text;
      Dossier dossier = Dossier(
          numero: numero,
          utilisateur: utilisateur,
          sigle: sigle,
          date: _selectedDate,
          observation: observation,
          statut: Statut.Arrive);
      // dossierService.saveDossier(dossier).then(redirect).catchError(onError);
      dossierService.saveDossier(dossier).then(onSuccess).catchError(onError
          // (err) => {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: new Text('Erreur, $err'),
          //     backgroundColor: Colors.redAccent,
          //     duration: const Duration(milliseconds: 1500000)))
          // }
          );
    }
  }

  onError(err) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: new Text('Erreur, $err'),
        backgroundColor: Colors.redAccent,
        duration: const Duration(milliseconds: 1500000)));
  }

  onSuccess(value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: new Text("Arrivé"),
      backgroundColor: Colors.green,
    ));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new RecherchePage()),
    );
  }
}
