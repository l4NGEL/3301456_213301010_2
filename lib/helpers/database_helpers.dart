import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static Database? _database;

  DatabaseHelper._getInstance();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'medicine.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS medicines(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        dosage INTEGER,
        isTaken INTEGER
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getMedicines() async {
    final Database db = await instance.database;
    return await db.query('medicines');
  }

  Future<int> insertMedicine(Map<String, dynamic> medicine) async {
    final Database db = await instance.database;
    return await db.insert('medicines', medicine);
  }


  Future<int> updateMedicine(Map<String, dynamic> medicine) async {
    final Database db = await instance.database;
    final int id = medicine['id'];
    return await db.update('medicines', medicine, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteMedicine(int id) async {
    final Database db = await instance.database;
    return await db.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }
}
