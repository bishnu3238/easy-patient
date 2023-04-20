import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (int id, title, body, payload) {});
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (details) {
      var data;
      if (details.payload != null) {
        data = jsonDecode(details.payload!);
        // handleNotificationClick(details.payload, context, data);

      } else {
        print(details.actionId);
      }
    }, onDidReceiveNotificationResponse: (details) {
      print(details.payload);
      print(details.actionId);
      print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    });
  }

  Future showNotification(data,  patient) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "INCOMING-CALL",
      "Incoming Call",
      priority: Priority.max,
      importance: Importance.max,
      icon: '@mipmap/ic_launcher',
      ongoing: true,
      autoCancel: false,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      channelAction: AndroidNotificationChannelAction.createIfNotExists,
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      channelShowBadge: true,
      actions: [
        AndroidNotificationAction(
          'ans',
          'Answer',
          titleColor: Color.fromARGB(255, 255, 0, 0),
          // icon: 'ic_answer',
        ),
        AndroidNotificationAction('rej', 'Decline',
            titleColor: Color.fromARGB(255, 255, 0, 0),
            inputs: [AndroidNotificationActionInput()]),
      ],
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    return await notificationsPlugin.show(0, "Incoming Call",
        "Call from ${data["callerId"]}", notificationDetails,
        payload: jsonEncode(data));
  }

}
