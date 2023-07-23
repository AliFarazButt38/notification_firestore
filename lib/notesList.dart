import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit note.dart';

class NoteListPage extends StatefulWidget {


  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  int currentPage = 0;
  int pageSize = 10;
   List<QueryDocumentSnapshot> notes=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes list"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error while fetching notes'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          notes = snapshot.data!.docs;

          if (notes.isEmpty) {
            return const Center(child: Text('No notes available'));
          }

          if (currentPage >= notes.length) {
            currentPage = notes.length - 1;
          }

          final note = notes[currentPage];
          final title = note['title'];
          final description = note['description'];
          final date = note['date'].toDate();

          return PageView(
            controller: PageController(viewportFraction: 1.0, initialPage: currentPage),
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            children: List<Widget>.generate((notes.length / pageSize).ceil(), (pageIndex) {
              final startIndex = pageIndex * pageSize;
              final endIndex = (startIndex + pageSize) <= notes.length ? (startIndex + pageSize) : notes.length;
              final pageNotes = notes.sublist(startIndex, endIndex);

              return SingleChildScrollView(
                child: Column(
                  children: pageNotes.map((note) {
                    final title = note['title'];
                    final description = note['description'];
                    final date = note['date'].toDate();

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNotePage(noteTitle: title),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(description),
                        trailing: Text(date.toString()),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          );
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (currentPage > 0) {
                  currentPage--;
                }
              });
            },
            icon: Icon(Icons.arrow_back),
            // Disable the back button if on the first page
            disabledColor: currentPage == 0 ? Colors.grey : null,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (currentPage < (notes.length / pageSize).ceil() - 1) {
                  currentPage++;
                }
              });
            },
            icon: Icon(Icons.arrow_forward),
            // Disable the forward button if on the last page
            disabledColor: currentPage == (notes.length / pageSize).ceil() - 1 ? Colors.grey : null,
          ),
        ],
      ),

    );
  }
}
