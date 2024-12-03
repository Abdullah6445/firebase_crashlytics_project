import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'flutter_local_notification.dart';

class FirebaseMsgApi {
  static final firebaseMessageApi = FirebaseMessaging.instance;

  //function to initialize notification
  static Future<void> initNotification() async {
    //req permission
    await firebaseMessageApi.requestPermission();
    //fetch token for device
    final token = await firebaseMessageApi.getToken();
    //display token
    debugPrint("<===== token for device : $token =====>");

    initPushNotifications();
  }

  // now function to handle receive message

  static handleReceiveMessage(RemoteMessage? msg) {
    if (msg == null) {
      debugPrint("<===== message null aya hai =====>");
      return;
    }

    //agr msg aa gya
    debugPrint("<===== message aa aya hai =====>");

    navigatorKey.currentState!
        .pushNamed('/notification_screen', arguments: msg);
  }

  static Future initPushNotifications() async {
    // jab foreground par ho
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("<===== Foreground message received =====>");
      NotificationService.showNotification(message);
    });

    // jab background ya terminate hwi v ho
    // firebaseMessageApi.getInitialMessage().then(handleReceiveMessage);
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

    //jab app notification se open ho
    FirebaseMessaging.onMessageOpenedApp.listen(handleReceiveMessage);
  }
}
