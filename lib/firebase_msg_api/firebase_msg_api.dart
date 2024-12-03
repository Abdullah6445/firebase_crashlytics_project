import 'package:firebase_crashlytics_project/firebase_messaging/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'flutter_local_notification.dart';

class FirebaseMsgApi {
  final firebaseMessageApi = FirebaseMessaging.instance;

  //function to initialize notification
  Future<void> initNotification() async {
    //req permission
    await firebaseMessageApi.requestPermission();
    //fetch token for device
    final token = await firebaseMessageApi.getToken();
    //display token
    debugPrint("<===== token for device : $token =====>");

    initPushNotifications();
  }

  // now function to handle receive message

  handleReceiveMessage(RemoteMessage? msg) {
    if (msg == null) {
      debugPrint("<===== message null aya hai =====>");
      return;
    }

    //agr msg aa gya
    debugPrint("<===== message aa aya hai =====>");

    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        ));

    // navigatorKey.currentState!
    //     .pushNamed('/notification_screen', arguments: msg);
  }

  // function to initialize background setting

  // Future initPushNotifications() async {
  //   //agr app terminate ho k again open hwi
  //   firebaseMessageApi.getInitialMessage().then(handleReceiveMessage);

  //   // jab app notification se open ho
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleReceiveMessage);
  // }

  Future initPushNotifications() async {
    // For foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("<===== Foreground message received =====>");
      NotificationService.showNotification(message);
    });

    // For background/tapped notifications
    firebaseMessageApi.getInitialMessage().then(handleReceiveMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleReceiveMessage);
  }
}
