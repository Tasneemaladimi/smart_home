import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'devices.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE devices(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            iconCodePoint INTEGER,
            status INTEGER
          )
        ''');
      },
    );
  }

  static Future<int> insertDevice(Map<String, dynamic> device) async {
    final db = await database;
    return await db.insert('devices', device);
  }

  static Future<List<Map<String, dynamic>>> getDevices() async {
    final db = await database;
    return await db.query('devices');
  }

  static Future<int> updateDevice(int id, Map<String, dynamic> device) async {
    final db = await database;
    return await db.update('devices', device, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteDevice(int id) async {
    final db = await database;
    return await db.delete('devices', where: 'id = ?', whereArgs: [id]);
  }
}
