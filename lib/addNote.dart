
import 'package:flutter/material.dart';
import 'package:notification/services/firestore_service.dart';

import 'notesList.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title= TextEditingController();
  TextEditingController desc= TextEditingController();
  bool loading= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          TextField(
            controller: title,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: desc,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),
          if (loading) Center(child: CircularProgressIndicator(),) else ElevatedButton(onPressed: ()async
          {
            if(title.text=="" || desc.text==""){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are requiresd")));
            }else{
              setState(() {
                loading=true;
              });
              await FireStoreService().insertNote(title.text,desc.text);
              setState(() {
                loading=false;
              });

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteListPage()),
              );
            }
          }, child: Text("Add Note")),
        ],
      ),
    );
  }
}
