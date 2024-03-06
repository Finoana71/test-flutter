import 'package:flutter/material.dart';
import 'package:gestiondossier/services/sqlite_service.dart';
import 'package:gestiondossier/widgets/home/home-card.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Get.snackbar('Success', 'the user has been created successfully.');

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
