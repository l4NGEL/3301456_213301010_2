import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BloodTest {
  final int id;
  final String name;
  final String date;
  final String result;

  BloodTest({required this.id, required this.name, required this.date, required this.result});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'result': result,
    };
  }
}

class BloodTestDatabase {
  static const bloodTestTable = 'blood_tests';
  static Database? _database;

  static Future<void> initialize() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'blood_test_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE $bloodTestTable(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, date TEXT, result TEXT)',
          );
        },
        version: 1,
      );
    }
  }

  static Future<void> insertBloodTest(BloodTest bloodTest) async {
    await _database!.insert(
      bloodTestTable,
      bloodTest.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<BloodTest>> getBloodTests() async {
    final List<Map<String, dynamic>> maps = await _database!.query(bloodTestTable);

    return List.generate(maps.length, (i) {
      return BloodTest(
        id: maps[i]['id'],
        name: maps[i]['name'],
        date: maps[i]['date'],
        result: maps[i]['result'],
      );
    });
  }
}
