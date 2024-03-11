// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SnackBarHelper {
  success(String text, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: new Text(text), backgroundColor: Colors.greenAccent));
  }

  void error(String err, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: new Text('Erreur, $err'),
        backgroundColor: Colors.redAccent,
        duration: const Duration(milliseconds: 1500000)));
  }
}
