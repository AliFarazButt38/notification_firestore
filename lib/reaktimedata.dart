import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:notification/realtimeDatabseList.dart';

class RealTime extends StatefulWidget {
  const RealTime({Key? key}) : super(key: key);

  @override
  State<RealTime> createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  final databaseRef = FirebaseDatabase.instance.reference().child('your_node');
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }
  void addData() {
    String name = nameController.text;
    String email = emailController.text;

    databaseRef.push().set({
      'name': name,
      'email': email,
    }).then((_) {
      print('Data added successfully!');
      // Clear the text fields after adding data
      nameController.clear();
      emailController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DataListPage(),
        ),
      );
    }).catchError((error) {
      print('Failed to add data: $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addData,
              child: Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }
}
