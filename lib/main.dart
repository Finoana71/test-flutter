import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestiondossier/screens/home.dart';
import 'package:gestiondossier/services/sqlite_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // Initialisez la fabrique de base de données FFI
//   if (kIsWeb) {
//     // Change default factory on the web
//     databaseFactory = databaseFactoryFfiWeb;
// // open the database
//   } else {
//   }

  // databaseFactory = databaseFactoryFfi;
  // databaseFactory = databaseFactoryFfi;

  // Reste de votre code
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
