
import 'package:belajar_flutter/models/note.dart';
import 'package:belajar_flutter/screens/form_note.dart';
import 'package:belajar_flutter/screens/preview.dart';
import 'package:belajar_flutter/service/note_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> _noteList=[];
  NoteService noteService=NoteService();

  // initData()async{
  //   _noteService.get();
  // }
 
  @override
  void initState(){
    _getAllNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _noteList.length,
        itemBuilder: (context,index){
          return Card(
           child: ListTile(
            onTap: () {
              _openPreview(_noteList[index]);
            },
            leading: const Icon(Icons.receipt),
            title: Text(_noteList[index].title),
            subtitle: Text(DateFormat('yMMMMd').format(DateTime.parse(_noteList[index].created_at)) ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: (){
                    _openFormEdit(_noteList[index]);
                  },
                  icon: const Icon(Icons.edit,color: Colors.cyan,)
                ),
                IconButton(
                  onPressed:(){
                  // action on delete
                  _deleteNote(_noteList[index].id);
                  },
                  icon: const Icon(Icons.delete,color: Colors.amber,)
                  )
              ],
            ),
           ),
          );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed:(){ 
          _openFormInsert();
        },
        // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
  Future<void> _getAllNote() async {
    var list = await noteService.get();
      setState(() {
        _noteList.clear();
        _noteList=list;        
      });
  }

  Future<void> _deleteNote(int id) async {
    await noteService.delete(id);
    await _getAllNote();
  }

  Future<void> _openFormInsert() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FormNote()));
        if(result=='update' || result=='save'){
          await _getAllNote();
        }
    
  }

  Future<void> _openFormEdit(Note note) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  FormNote(note: note)));
    if (result == 'update' || result == 'save') {
      await _getAllNote();
    }
  }


  

Future<void> _openPreview(Note note) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Preview(note: note)));
    
  }
  
}


