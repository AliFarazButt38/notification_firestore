
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification/NewDesign.dart';
import 'package:notification/addNote.dart';
import 'package:notification/cube.dart';
import 'package:notification/firestore.dart';
import 'package:notification/home.dart';
import 'package:notification/navigatorKey.dart';
import 'package:notification/reaktimedata.dart';
import 'package:notification/screens/home_screen.dart';
import 'package:notification/uni_services.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UniService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Context.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'We chat',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
          titleTextStyle: TextStyle(
            color: Colors.black,fontWeight: FontWeight.normal, fontSize: 20,
          ),
          backgroundColor: Colors.white

        ),
        iconTheme: const IconThemeData(
          color: Colors.black
        ),

        primarySwatch: Colors.blue,
      ),
      // routes: {
      //   '/': (_) => AddNote(),
      //   '/green' : (_) => Home(),
      //   '/red' : (_) => HomeScreen()
      // },
      home:  FireStore(),

    );
  }
}

