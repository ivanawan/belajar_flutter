// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:belajar_flutter/models/note.dart';
import 'package:belajar_flutter/service/note_service.dart';
import 'package:flutter/material.dart';

class FormNote extends StatefulWidget{
final Note? note;
const FormNote({super.key, this.note});

  @override
  MyFormState createState() {
    return MyFormState();
  }
  
}

class MyFormState extends State<FormNote>{
final _formKey = GlobalKey<FormState>();
NoteService _noteService= NoteService();

TextEditingController? title;
TextEditingController? note;

@override
initState(){
  setState(() {
  title= TextEditingController(
          text: widget.note == null ? '' : widget.note!.title);
  note = TextEditingController(
          text: widget.note == null ? '' : widget.note!.note);

  });
  super.initState();
}
  @override
  Widget build(BuildContext context){
   return Scaffold(
    appBar: AppBar(
      title:const Text('Form Input'),
      // leading: IconButton(
      //   onPressed: () {
          
      //   },
      //   icon:Icon(Icons.arrow_back)
      //   ),
      ),
      body:SingleChildScrollView( 
        child: Form(
          key:_formKey,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'title',
                  ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: TextFormField(
                controller: note,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Note',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: (widget.note == null)
                    ? const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () {
                  upsetNote();
                },
              ),
            ),  
            
            ],
          ),
          )
          )
   );
  }
  
  submit() {}
  
  Future upsetNote() async {
    try {
      if (widget.note != null) {
        //update
        await _noteService.update(Note(
          id: widget.note!.id,
          title: title!.text,
          note: note!.text
        ));
        Navigator.pop(context, 'update');
      } else {
        //insert
        await _noteService.insert(Note(
          id: 0,
          title: title!.text,
          note: note!.text
        ));
        Navigator.pop(context, 'save');
      }
    } catch (Exc) {
      print(Exc);
    }
  }
}