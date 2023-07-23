import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  FirebaseFirestore firestore= FirebaseFirestore.instance;

  Future insertNote(String title, String description)async{
try{
await firestore.collection('notes').add({
  "title":title,
  "description": description,
  "date":DateTime.now(),

});
}catch(e){
print("error");
}
  }
}