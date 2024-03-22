import 'package:gestiondossier/db/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class DossierRepository {
  late DatabaseConnection _databaseConnection;

  DossierRepository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  String table = "dossiers";

  static Future<void> removeDatabase(String dbPath) async {
    await _database?.close();
    if (_database != null) await deleteDatabase(dbPath);
    _database = null;
  }

  static Future<void> closeDatabase() async {
    if (_database == null) return;
    await _database?.close();
    _database = null;
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  Future<int?> insertData(Map<String, dynamic> data, String? table) async {
    if (table == null) table = this.table;
    var connection = await database;
    return await connection?.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static bool isDatabaseOpen() {
    if (_database == null) return false;
    // Vérifiez si la base de données est ouverte
    return _database!.isOpen;
  }

  Future<List<Map<String, dynamic>>?> readData(
      String search, String? where, List? whereArgs) async {
    var connection = await database;
    return await connection?.query(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>?> readAllData(
      String table, String where, List whereArgs) async {
    var connection = await database;
    return await connection?.query(table,
        where: where, whereArgs: whereArgs, orderBy: "date DESC");
  }

  Future<List<Map<String, dynamic>>?> readAllDataNoCondition(
      String table) async {
    var connection = await database;
    return await connection?.query(table, orderBy: "date DESC");
  }

  Future<List<Map<String, dynamic>>?> readDataById(int dossierId) async {
    var connection = await database;
    return await connection
        ?.query(table, where: 'id = ?', whereArgs: [dossierId]);
  }

  Future<List<Map<String, dynamic>>?> readDataByNumero(String numero) async {
    var connection = await database;
    return await connection
        ?.query(table, where: 'numero = ?', whereArgs: [numero]);
  }

  Future<int?> updateData(Map<String, dynamic> data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int?> deleteData(String where, List whereArgs, String? table) async {
    var connection = await database;
    table = table ?? this.table;
    return await connection?.delete(table, where: where, whereArgs: whereArgs);
  }
}
