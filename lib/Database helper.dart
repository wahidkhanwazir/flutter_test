import 'package:fluttertest/Database%20Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  static const String dbName = 'holistic_services.db';
  static const String tableName = 'services'; // Ensure this matches your table name

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, dbName),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY,
            name TEXT,
            title TEXT,
            category TEXT,
            duration INTEGER,
            type TEXT,
            price REAL,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return NoteModel.fromMap(maps[i]);
    });
  }

  Future<int> insert(NoteModel note) async {
    final db = await database;
    print("Inserting: ${note.toMap()}");
    return await db.insert(tableName, note.toMap());
  }

  Future<int> delete(int id) async {
    var dbClient = await database;
    return await dbClient.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> update(NoteModel note) async {
    final db = await database;
    await db.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
