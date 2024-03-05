import 'package:gestiondossier/db/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class DossierRepository {
  late DatabaseConnection _databaseConnection;

  dossierRepository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  String table = "dossiers";

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  Future<int?> insertData(Map<String, dynamic> data) async {
    var connection = await database;
    return await connection?.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>?> readData() async {
    var connection = await database;
    return await connection?.query(table);
  }

  Future<List<Map<String, dynamic>>?> readDataById(int dossierId) async {
    var connection = await database;
    return await connection
        ?.query(table, where: 'id = ?', whereArgs: [dossierId]);
  }

  Future<int?> updateData(Map<String, dynamic> data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int?> deleteDataById(int dossierId) async {
    var connection = await database;
    return await connection
        ?.delete(table, where: 'id = ?', whereArgs: [dossierId]);
  }
}
