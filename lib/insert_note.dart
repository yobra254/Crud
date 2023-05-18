import 'package:flutter/material.dart';
import 'package:notes/databasehelper.dart';
import 'package:notes/note.dart';
import 'package:sqflite/sqlite_api.dart';

class InsertNote extends StatefulWidget {
  //const InsertNote({super.key});

  final Function updateListView;

  InsertNote(this.updateListView);

  @override
  State<InsertNote> createState() => _InsertNoteState();
}

class _InsertNoteState extends State<InsertNote> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final myTitle = TextEditingController();
  final myDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Insert Notes',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400],
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myTitle,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.note),
                        border: OutlineInputBorder(),
                        hintText: "Description"),
                    maxLength: 255,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Add This Note',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Note note = Note(myTitle.text, myDescription.text);
                    insertNote(context, note);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[400],
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
