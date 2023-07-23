import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNotePage extends StatefulWidget {
  final String noteTitle;

  const EditNotePage({required this.noteTitle});

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController title;
  late TextEditingController desc;
  bool loading = false;
  bool loading2=false;
  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    desc = TextEditingController();

    fetchNoteDetails();
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  Future<void> fetchNoteDetails() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('notes')
          .where('title', isEqualTo: widget.noteTitle)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final noteData = snapshot.docs.first.data() as Map<String,dynamic>;
        title.text = noteData['title'] ?? '';
        desc.text = noteData['description'] ?? '';
      }
    } catch (e) {
      print('Error fetching note details: $e');
    }
  }


  Future<void> updateNote() async {
    setState(() {
      loading = true;
    });
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('notes')
          .where('title', isEqualTo: widget.noteTitle)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final noteId = snapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('notes')
            .doc(noteId)
            .update({
          'title': title.text,
          'description': desc.text,
        });

        Navigator.pop(context);
      } else {
        print('Note not found');
      }
    } catch (e) {
      print('Error updating note: $e');
    }
    setState(() {
      loading = false;
    });
  }
  Future<void> deleteNote() async {
    setState(() {
       loading2=true;
    });
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('notes')
          .where('title', isEqualTo: widget.noteTitle)
          .get();



      if (snapshot.docs.isNotEmpty) {
        final noteId = snapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('notes')
            .doc(noteId)
            .delete();

        Navigator.pop(context);
      } else {
        print('Note not found');
      }
    } catch (e) {
      print('Error deleting note: $e');
    }
    setState(() {
      loading2=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: desc,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading ? null : updateNote,
              child: loading ? CircularProgressIndicator() : const Text('Update Note'),
            ),
            ElevatedButton(
              onPressed: loading2 ? null : deleteNote,
              child: loading2 ? CircularProgressIndicator() : const Text('Delete Note'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
