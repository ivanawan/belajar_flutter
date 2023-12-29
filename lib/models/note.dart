import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Note {
  late int id;
  late String title;
  late String note;
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String created_at=dateFormat.format(DateTime.now()); 
  
  Note({required this.id, required this.title, required this.note});
  Note.full({required this.id, required this.title, required this.note, required this.created_at});

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'title':title,
      'note':note,
      'created_at':created_at
    };
  }

  Map<String, dynamic> toMapStore() {
    return {
      'title': title,
      'note': note,
      'created_at': created_at
      };
  }

}