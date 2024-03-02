import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  MyButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Couleur de fond du bouton
        onPrimary: Colors.white, // Couleur du texte du bouton
        padding: EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 40.0), // Marges intérieures du bouton
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), // Bordure arrondie du bouton
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0), // Taille du texte du bouton
      ),
    );
  }
}
