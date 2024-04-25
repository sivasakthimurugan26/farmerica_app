import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late FlutterLocalNotificationsPlugin fltrNotification;
  String? _selectedParam;
  String? task;
  int? val;

  @override
  void initState() {
    super.initState();
    AndroidInitializationSettings androidInitilize =
    const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings iOSinitilize =   const DarwinInitializationSettings();
    InitializationSettings initilizationsSettings =  InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification =  FlutterLocalNotificationsPlugin();
    // fltrNotification.initialize(initilizationsSettings,
    //     onDidReceiveNotificationResponse: notificationSelected);
    fltrNotification.initialize(initilizationsSettings,
        onDidReceiveNotificationResponse: null);
  }

  Future showNotification(String task) async {
    var androidDetails = const AndroidNotificationDetails(
        "Channel ID", "Desi programmer");
    var iOSDetails =  const DarwinNotificationDetails();
    var generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iOSDetails);

    // await fltrNotification.show(
    //     0, "Task", "You created a Task", generalNotificationDetails, payload: "Task");
    var scheduledTime;

    scheduledTime = DateTime.now().add(Duration(seconds: 5));

    fltrNotification.zonedSchedule(
      1,
      "Farmerica App",
      task,
      scheduledTime,
      generalNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked $payload"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
