import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final Widget pageInstance; // Instance de la page à affiche

  HomeButton({
    required this.color,
    required this.text,
    required this.icon,
    required this.pageInstance,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Bordure arrondie
        ),
        primary: color, // Couleur du bouton
        onPrimary: Colors.white, // Couleur du texte du bouton
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height *
              0.04, // Ajustez ce coefficient selon vos besoins
          horizontal: 16.0,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pageInstance),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32, // Taille de l'icône plus grande
          ),
          SizedBox(height: 8.0), // Espace entre l'icône et le texte
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
