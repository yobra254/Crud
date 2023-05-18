import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:notes/databasehelper.dart';
import 'package:notes/insert_note.dart';
import 'package:notes/insert_note.dart';
import 'package:notes/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note>? notes;
  late int count;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return notes == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(""),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[400],
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      label: Text(
                        'New Note',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InsertNote(updateListView),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[400],
                        elevation: 15.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey,
                                width: 1.5,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateNote(
                                      notes[index],
                                      updateListView,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(this.notes[index].title),
                                subtitle: Text(this.notes[index].descrition),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: notes.length,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void updateListView() {
    Future<Database> dbfuture = databaseHelper.initialDatabase();
    dbfuture.then((database) {
      Future<List<Note>> resfuture = databaseHelper.getListNote();
      resfuture.then((noteList) {
        setState(() {
          notes = noteList;
        });
      });
    });
  }
}
