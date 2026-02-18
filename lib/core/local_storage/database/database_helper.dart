import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal();
  factory DatabaseHelper() {
    return _databaseHelper ??= DatabaseHelper._internal();
  }

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDb();
  }

  static const String _tblProducts = 'products';

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'labamu.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblProducts (
        id TEXT PRIMARY KEY,
        name TEXT,
        price INTEGER,
        description TEXT,
        status TEXT,
        updatedAt TEXT
      )
    ''');
  }
}
