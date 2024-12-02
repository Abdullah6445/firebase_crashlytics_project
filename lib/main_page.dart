import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsDemoScreen extends StatefulWidget {
  const CrashlyticsDemoScreen({super.key});

  @override
  State<CrashlyticsDemoScreen> createState() => _CrashlyticsDemoScreenState();
}

class _CrashlyticsDemoScreenState extends State<CrashlyticsDemoScreen> {
  @override
  void initState() {
    super.initState();
    executeRepeatedly();
  }

  void executeRepeatedly() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      // Your code here
      print("This code executes every 5 seconds!");
      throw Exception("==== This is exception ====>");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crashlytics'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildButton(
            context,
            label: "Trigger Fatal Crash",
            onPressed: () {
              // This will cause a fatal crash
              throw Exception("This is a test fatal crash!");
            },
          ),
          _buildButton(
            context,
            label: "Trigger Non-Fatal Error",
            onPressed: () {
              try {
                int result = 42 ~/ 0; // Divide by zero
                print(result);
              } catch (e, stack) {
                FirebaseCrashlytics.instance.recordError(e, stack);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String label, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

// import 'package:firebase_crashlytics_project/second_page.dart';
// import 'package:flutter/material.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             ListView.builder(
//               itemBuilder: (context, index) {
//                 return const ListTile(
//                   title: Text("dfssdf"),
//                 );
//               },
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SecondPage(),
//                     ));
//               },
//               child: const Text("Move to Second Page"),
//             ),
//             ElevatedButton(
//                 onPressed: () => throw Exception(),
//                 child: const Text("Throw Test Exception main page")),
//           ],
//         ),
//       ),
//     );
//   }
// }
