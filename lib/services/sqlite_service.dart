import 'package:gestiondossier/models/dossier.dart';
import 'package:gestiondossier/models/historique.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final String tableDossier = 'dossiers';
final String tableHistorique = 'historiques';

class SqliteService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDB();
    return _database!;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    // databaseFactory = databaseFactoryFfi;
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute('''
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

        await database.execute('''
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
      version: 1,
    );
  }

  Future<List<Dossier>> getDossiers() async {
    final db = await database;
    final List<Map<String, dynamic>> dossierMaps = await db.query(tableDossier);

    return List.generate(dossierMaps.length, (i) {
      return Dossier.fromMap(dossierMaps[i]);
    });
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
}
