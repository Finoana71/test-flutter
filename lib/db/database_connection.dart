import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableDossier = 'dossiers';
final String tableHistorique = 'historiques';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_dossiers');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await _createTableDossier(database);
    await _createTableHistorique(database);
  }

  Future<void> _createTableDossier(Database db) async {
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
  }

  Future<void> _createTableHistorique(Database db) async {
    await db.execute('''
          CREATE TABLE $tableHistorique (
            id INTEGER PRIMARY KEY,
            idDossier INTEGER,
            utilisateur TEXT,
            sigle TEXT,
            date INTEGER,
            observation TEXT,
            statut TEXT,
            FOREIGN KEY (idDossier) REFERENCES $tableDossier(id)
          )
        ''');
  }
}
