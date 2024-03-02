import 'package:flutter/material.dart';
import 'package:gestiondossier/services/sqlite_service.dart';
import 'package:gestiondossier/widgets/home/home-card.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image(
            image: AssetImage('assets/logo01.png'),
          ),
        ),
        Expanded(
          child: HomeCard(),
        ),
      ],
    );
  }
}
