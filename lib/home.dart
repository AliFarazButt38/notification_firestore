import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
   void initState(){
    getToken();
    requestPermission();
    initInfo();
    super.initState();
  }

  getToken() async{
    String deviceToken= await getDeviceToken();
    print('Device-token(!!!!!!!!!!!)$deviceToken');
  }
  void requestPermission()async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted  permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('user granted provisional permission');
    }else{
      print('user declined permission');
    }
  }
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }
  initInfo()async{
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a Notification: ${message.notification}');
        AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails('12132', 'wemeet', importance: Importance.high,priority: Priority.high,playSound: true);
        NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: const DarwinNotificationDetails());
        await flutterLocalNotificationsPlugin.show(0, message.notification?.title, message.notification?.body, notificationDetails,payload: message.data['title']);
      }
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Notifications"),
      ),
    );
  }

  Future getDeviceToken() async {
    FirebaseMessaging _firebaseMessage= FirebaseMessaging.instance;
    String? deviceToken= await _firebaseMessage.getToken();
    return (deviceToken==null) ? " " : deviceToken;
  }
}




