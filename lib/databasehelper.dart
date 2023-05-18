import 'dart:async';

import 'package:notes/note.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String tableName = 'note_table';
  String noteId = "id";
  String noteTitle = "name";
  String noteDesc = "desc";

  static late Database _database;
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  DatabaseHelper.createInstance();

  Future<Database> get database async {
    _database = await initialeDatabase();
    return _database;
  }

  Future<Database> initialeDatabase() async {
    String directory = await getDatabasesPath();
    String path = directory + 'notes.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDB);
    return notesDatabase;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName($noteId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$noteTitle TEXT,$noteDesc TEXT)');
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM $tableName');
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = db.insert(tableName, note.toMap());
    return result;
  }

  Future<int> updateNote(int id, Note note) async {
    Database db = await this.database;
    var result = db.rawUpdate(
        'UPDATE $tableName SET $noteTitle=?, $noteDesc=? WHERE $noteId=?',
        [note.title, note.description, id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = db.delete(tableName, where: '$noteId=?', whereArgs: [id]);
    return result;
  }

  Future<int?> getNoteCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result =
        await db.query('SELECT 8 FROM $tableName');
    int? res = Sqflite.firstIntValue(result);
  }

  Future<List<Note>> getListNote() async {
    List<Note> notes = [];
    List<Map<String, dynamic>> result = await this.getAllNotes();
    for (Map<String, dynamic> mp in result) {
      notes.add(Note.toNote(mp));
    }
    return notes;
  }
}
