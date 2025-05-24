import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../entity/actividad.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<void> initializeDatabase() async {
    await database;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'activity_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE activities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fecha TEXT NOT NULL,
        nombre TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertActivity(Actividad activity) async {
    final db = await database;

    await db.insert(
      'activities',
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Actividad>> getActivities() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('activities');

    return List.generate(maps.length, (i) {
      return Actividad.fromMap(maps[i]);
    });
  }
}
