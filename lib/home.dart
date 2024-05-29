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
  void initState() {
    super.initState();
    getToken();
    // initInfo();
  }
  Future getDeviceToken() async {
    FirebaseMessaging _firebaseMessage= FirebaseMessaging.instance;
    String? deviceToken= await _firebaseMessage.getToken();
    return (deviceToken==null) ? " " : deviceToken;
  }


  getToken() async{
    String deviceToken= await getDeviceToken();
    print('Device-token(!!!!!!!!!!!)$deviceToken');
  }
  void initInfo() async {
    var androidInitialize =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: androidInitialize, );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a Notification: ${message.notification}');
        AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('12132', 'wemeet',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true);
        NotificationDetails notificationDetails = NotificationDetails(
            android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title,
            message.notification!.body,
            notificationDetails,
            payload: message.data['title']);
      }
    });
  }

  Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    debugPrint('notification payload: ${notificationResponse.payload}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showNotification();
              },
              child: Text("Click"),
            ),
            Center(
              child: Text("Notifications"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showNotification() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Notification',
      'This is a test notification',
      platformChannelSpecifics,
      payload: 'New Payload',
    );

  }
}
