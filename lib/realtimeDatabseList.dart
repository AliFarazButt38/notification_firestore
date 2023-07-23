import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class DataListPage extends StatefulWidget {
  @override
  _DataListPageState createState() => _DataListPageState();
}

class _DataListPageState extends State<DataListPage> {
  final databaseRef = FirebaseDatabase.instance.reference().child('your_node');
  List<Map<dynamic, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    // Listen for changes in the database
    databaseRef.onChildAdded.listen((event) {
      setState(() {
        dataList.add(Map<dynamic, dynamic>.from(event.snapshot.value as Map));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data List'),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(dataList[index]['name']),
            subtitle: Text(dataList[index]['email']),
          );
        },
      ),
    );
  }
}
