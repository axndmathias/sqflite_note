import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/note_model.dart';

class NoteService {
  // Database version
  static const int _version = 1;

  // Database name
  static const String _dbName = "Notes.db";

// Create and get a Database
  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);"),
        version: _version);
  }

// Add a Note
  static Future<int> addNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.insert("Note", noteModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.update("Note", noteModel.toJson(),
        where: 'id = ?',
        whereArgs: [noteModel.id],

        // conflict caracter resolver
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [noteModel.id],
    );
  }

  static Future<List<NoteModel>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => NoteModel.fromJson(maps[index]));
  }
}
