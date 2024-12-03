import 'package:flutter/material.dart';

class FirebaseMessageScreen extends StatefulWidget {
  const FirebaseMessageScreen({super.key});

  @override
  State<FirebaseMessageScreen> createState() => _FirebaseMessageScreenState();
}

class _FirebaseMessageScreenState extends State<FirebaseMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Message"),
      ),
    );
  }
}
