import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsDemoScreen extends StatelessWidget {
  const CrashlyticsDemoScreen({super.key});

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
          _buildButton(
            context,
            label: "Log Custom Event",
            onPressed: () {
              FirebaseCrashlytics.instance
                  .log("User performed a custom action.");
            },
          ),
          _buildButton(
            context,
            label: "Trigger Async Error",
            onPressed: () async {
              Future.delayed(Duration(seconds: 1), () {
                throw Exception("This is an async error!");
              });
            },
          ),
          _buildButton(
            context,
            label: "Log Breadcrumb",
            onPressed: () {
              FirebaseCrashlytics.instance
                  .log("User navigated to CrashlyticsDemoScreen.");
            },
          ),
          _buildButton(
            context,
            label: "Trigger Platform-Specific Error",
            onPressed: () {
              // Simulate a native platform error. This is a placeholder.
              FirebaseCrashlytics.instance
                  .log("Simulated platform-specific error.");
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
