import 'package:flutter/material.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:gestiondossier/screens/detail.dart';
import 'package:gestiondossier/screens/prise.dart';
import 'package:gestiondossier/screens/recherche.dart';
import 'package:gestiondossier/screens/retour.dart';
import 'package:gestiondossier/services/dossier.dart';
import 'package:gestiondossier/services/dossier_service.dart';
import 'package:gestiondossier/widgets/my-button.dart';

class FormRetourPage extends StatefulWidget {
  @override
  _FormRetourPageState createState() => _FormRetourPageState();

  Dossier dossier;

  FormRetourPage({required this.dossier});
}

class _FormRetourPageState extends State<FormRetourPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _utilisateurController = TextEditingController();
  TextEditingController _sigleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TextEditingController _observationController = TextEditingController();
  DossierService dossierService = new DossierService();

  static Statut statut = Statut.Rendu;

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
    String title = 'Retour dossier ${widget.dossier.numero}';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              MyButton(text: 'Enregistrer', onPressed: validate),
            ],
          ),
        ),
      ),
    );
  }

  void validate() {
    if (_formKey.currentState!.validate()) {
      // Traitez les données du formulaire ici
      String utilisateur = _utilisateurController.text;
      String sigle = _sigleController.text;
      String observation = _observationController.text;

      // Accédez au dossier via l'objet widget
      Dossier dossier = widget.dossier;

      dossierService
          .updateStatutDossier(
              dossier, statut, utilisateur, sigle, observation, _selectedDate)
          .then(onSuccess)
          .catchError(onError);
    }
  }

  void navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new RecherchePage()),
    ); // Vous pouvez également rediriger vers une autre page ou effectuer une autre action
  }

  onError(err) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: new Text('Erreur, $err'),
        backgroundColor: Colors.redAccent,
        duration: const Duration(milliseconds: 2000)));
  }

  onSuccess(value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: new Text("Dossier rendu"),
      backgroundColor: Colors.green,
    ));
    clear();
    navigate();
  }

  clear() {
    _utilisateurController.text = "";
    _sigleController.text = "";
    _observationController.text = "";
  }
}
