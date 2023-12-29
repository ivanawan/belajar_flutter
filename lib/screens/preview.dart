import 'package:belajar_flutter/models/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Preview extends StatelessWidget{
 final Note? note;
 const Preview({super.key, required this.note});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     appBar: AppBar(title: const Text('Detail Note')),
     body:Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 5),
        child: Text(note!.title,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 20)
                    ),
      ),
        Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                  DateFormat('yMMMMEEEEd')
                      .format(DateTime.parse(note!.created_at)),
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 13)),
            ),

       Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                note!.note,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 16),
              ),
            ), 
        
      ],
      )
    );
  }
}