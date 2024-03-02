import 'package:flutter/foundation.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final String tableDossier = 'dossiers';
final String tableHistorique = 'historiques';

class DatabaseHelper {
  static Database? _database;
  static final _dbName = 'your_database.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);
    if (kIsWeb) path = 'my_web_web.db';

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableDossier (
            id INTEGER PRIMARY KEY,
            numero TEXT,
            utilisateur TEXT,
            sigle TEXT,
            date INTEGER,
            observation TEXT,
            statut TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE $tableHistorique (
            id INTEGER PRIMARY KEY,
            dossierId INTEGER,
            utilisateur TEXT,
            sigle TEXT,
            date INTEGER,
            observation TEXT,
            statut TEXT,
            FOREIGN KEY (dossierId) REFERENCES $tableDossier(id)
          )
        ''');
      },
    );
  }

  Future<void> insertDossier(Dossier dossier) async {
    final db = await database;
    // Insert the Dossier
    int dossierId = await db.insert(tableDossier, dossier.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    Historique historique = dossier.generateFirstHistory(dossierId);

    await db.insert(tableHistorique, historique.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Dossier>> getDossiers() async {
    final db = await database;
    final List<Map<String, dynamic>> dossierMaps = await db.query(tableDossier);

    return List.generate(dossierMaps.length, (i) {
      return Dossier.fromMap(dossierMaps[i]);
    });
  }

  // Add more methods as needed

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
