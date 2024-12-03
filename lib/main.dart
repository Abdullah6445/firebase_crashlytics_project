import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crashlytics_project/firebase_messaging/notification_screen.dart';
import 'package:firebase_crashlytics_project/firebase_msg_api/firebase_msg_api.dart';
import 'package:flutter/material.dart';

import 'firebase_messaging/firebase_message_screen.dart';
import 'firebase_msg_api/flutter_local_notification.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMsgApi().initNotification();
  await NotificationService.initialize();
  FlutterError.onError = (errorDetails) {
    debugPrint("error aya hai");
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      navigatorKey: navigatorKey,
      home: const FirebaseMessageScreen(),
      routes: {
        "/notification_screen": (context) => const NotificationScreen(),
      },
    );
  }
}
