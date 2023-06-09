import 'package:flutter/material.dart';
import 'package:notes/databasehelper.dart';
import 'package:notes/note.dart';
import 'package:sqflite/sqlite_api.dart';

class UpdateNote extends StatefulWidget {
  //const UpdateNote({super.key});

  final Note note;
  final Function updateListView;
  UpdateNote(this.note, this.updateListView);

  @override
  //State<UpdateNote> createState() => _UpdateNoteState();
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final myTitle = TextEditingController();
  final myDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
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
                'Update Notes',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400],
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myTitle,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.title),
                  border: const OutlineInputBorder(),
                  hintText: widget.note.title,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myDescription,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.note),
                  border: const OutlineInputBorder(),
                  hintText: widget.note.description,
                ),
                maxLength: 255,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.update,
                color: Colors.white,
                size: 30.0,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Update This Note',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () async {
                print(myTitle.text);
                print(myDescription.text);
                if (myTitle.text == "") {
                  Note note = Note(widget.note.title, widget.note.description);
                  var value =
                      await databaseHelper.updateNote(widget.note.id!, note);
                  //updateNote(context, note);
                }
                if (myDescription.text == "") {
                  Note note = Note(widget.note.title, widget.note.description);
                  var value =
                      await databaseHelper.updateNote(widget.note.id!, note);
                  //updateNote(context, note);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 30.0,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Delete This Note',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () async {
                var value = await databaseHelper.deleteNote(widget.note.id!);
                //deleteNote(widget.note.id!, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateNote(BuildContext context, Note note) async {
    // await databaseHelper.updateNote(id, note);
  }
}
