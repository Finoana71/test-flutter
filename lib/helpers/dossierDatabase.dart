import 'package:gestiondossier/helpers/fields/dossier.dart';
import 'package:gestiondossier/models/dossier.dart';
import 'package:sqflite/sqflite.dart';

final String tableDossier = 'dossiers';
final String tableHistorique = 'historiques';

class DossierDatabase {
  static final DossierDatabase instance = DossierDatabase._internal();

  static Database? _database;

  DossierDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/dossier.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await _createTableDossier(db);
    await _createTableHistorique(db);
  }

  Future<void> _createTableDossier(Database db) async {
    await db.execute('''
          CREATE TABLE ${DossierFields.tableName} (
          ${DossierFields.id} ${DossierFields.idType},
          ${DossierFields.numero} ${DossierFields.textType},
          ${DossierFields.utilisateur} ${DossierFields.textType},
          ${DossierFields.sigle} ${DossierFields.textType},
          ${DossierFields.date} ${DossierFields.textType},
          ${DossierFields.observation} ${DossierFields.textType},
          ${DossierFields.statut} ${DossierFields.textType},
        )
        ''');
  }

  Future<void> _createTableHistorique(Database db) async {
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
  }

  Future<Dossier> createDossier(Dossier dossier) async {
    final db = await instance.database;
    final id = await db.insert(DossierFields.tableName, dossier.toJson());
    return dossier.copy(id: id);
  }

  Future<Dossier> readDossier(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      DossierFields.tableName,
      columns: DossierFields.values,
      where: '${DossierFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Dossier.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Dossier>> listDossier() async {
    final db = await instance.database;
    const orderBy = '${DossierFields.numero} ASC';
    final result = await db.query(DossierFields.tableName, orderBy: orderBy);
    return result.map((json) => Dossier.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
