
import 'package:flutter/material.dart';
import 'package:notification/addNote.dart';
import 'package:notification/edit%20note.dart';
import 'package:notification/notesList.dart';
import 'package:page_transition/page_transition.dart';

class FireStore extends StatefulWidget {

  const FireStore({Key? key}) : super(key: key);

  @override
  State<FireStore> createState() => _FireStoreState();
}

class _FireStoreState extends State<FireStore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore'),
        centerTitle: true,
      ),
      body: Container(
       child: Center(
         child: Column(
           children: [
             ElevatedButton(onPressed: (){
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote()));
               // Navigator.push(context, PageTransition(child: AddNote(), type: PageTransitionType.fade));
               // Navigator.push(context, PageTransition(child: AddNote(), type: PageTransitionType.leftToRight));
               Navigator.push(context, PageTransition(child: AddNote(),childCurrent: AddNote(),alignment: Alignment.center ,type: PageTransitionType.theme));




             }, child: Text("Add Note")),

             ElevatedButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteListPage()));
             }, child: Text("Notes List")),
           ],
         ),
       ),
      ),
    );
  }
}
