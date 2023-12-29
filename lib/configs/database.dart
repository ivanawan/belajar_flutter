import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

 Future<Database> initializeDatabase() async {
  final database = openDatabase(
      join(await getDatabasesPath(), 'note_database.db'),
      onCreate: (db, version) {
     return db.execute(
      'CREATE TABLE IF NOT EXISTS notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,note TEXT, created_at TIMESTAMP)',
    );
      },
      version: 1);
   return database;   
}
