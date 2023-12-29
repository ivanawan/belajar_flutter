import 'dart:async';

import 'package:belajar_flutter/models/note.dart';
import 'package:belajar_flutter/configs/database.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteService {
  final String tb_name='notes';
  static final NoteService _instance = NoteService._internal();
  static Database? _database;

  NoteService._internal();
  factory NoteService()=> _instance;


  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await initializeDatabase();
    return _database;
  }
  
  Future <List<Note>> get() async{
     var db = await _db;
    List<Map<String, dynamic>> result = await db!.query(tb_name);
    List<Note> noteLists = [];

    for (Map<String, dynamic> row in result) {
      noteLists.add(Note.full(id:row['id'], title:row['title'], note:row['note'], created_at:row['created_at']));
    }
    
    return noteLists;
  }
  
  Future<int> insert(Note note) async {
     var db = await _db;
    var result = await db!.insert(tb_name, note.toMapStore());
    return result;
  }

  Future<int> update(Note note) async {
     var db = await _db;
    int result = await db!.update(tb_name, note.toMapStore(), where: 'id = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> delete(int id) async {
     var db = await _db;
    int result = await db!.delete(tb_name, where: 'id = ?', whereArgs: [id]);
    return result;
  }
  
}