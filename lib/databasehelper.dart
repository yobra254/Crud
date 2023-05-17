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
    var notesDatabase = openDatabase(, version: 1, onCreate: _createDB);
    return notesDatabase;
  }

  void _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE $tableName($noteId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$noteTitle TEXT,$noteDesc TEXT)');
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async{
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM $tableName');
    return result;
  }

  Future<int> inserNote(Note note) async{
    Database db = await this.database;
    var result = db.insert(tableName, note.toMap());
    return result; 
  }

  Future<int> updateNote(int id, Note note) async{
    Database db = await this.database;
    var result = db.rawUpdate(
      'UPDATE $tableName SET $noteTitle=?, $noteDesc=? WHERE $noteId=?',
    (note.title, note.description, id));
    return result;
  }
  Future<int?> getNoteCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> 
  }
}
