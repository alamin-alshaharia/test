// import 'package:android_intent_plus/android_intent.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(AlarmApp());
// }
//
// class AlarmApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AlarmScreen(),
//     );
//   }
// }
//
// class AlarmScreen extends StatelessWidget {
//   // Method to attempt opening the clock app
//   Future<bool> openClockApp() async {
//     try {
//       // Try common URL schemes for opening the clock app
//       const url = 'clock://'; // Common URL scheme for clock apps
//       if (await canLaunch(url)) {
//         await launch(url);
//         return true;
//       }
//
//       // Try manufacturer-specific URL schemes
//       const samsungClockUrl = 'samsungclock://';
//       const xiaomiClockUrl = 'miuiclock://';
//       if (await canLaunch(samsungClockUrl)) {
//         await launch(samsungClockUrl);
//         return true;
//       } else if (await canLaunch(xiaomiClockUrl)) {
//         await launch(xiaomiClockUrl);
//         return true;
//       }
//
//       // Try opening the default Android clock app by package name
//       const androidClockPackageName = 'com.android.deskclock';
//       final AndroidIntent intent = AndroidIntent(
//         action: 'android.intent.action.MAIN',
//         package: androidClockPackageName,
//         category: 'android.intent.category.LAUNCHER',
//       );
//
//       await intent.launch();
//       return true;
//     } catch (e) {
//       print('Error launching clock app: $e');
//     }
//
//     return false; // No supported clock app found
//   }
//
//   // Method to show an error dialog if the clock app cannot be opened
//   void showErrorDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text('Could not open the clock app. Please open it manually.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Open Clock App'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             bool success = await openClockApp();
//             if (!success) {
//               showErrorDialog(context);
//             }
//           },
//           child: Text('Open Clock App'),
//         ),
//       ),
//     );
//   }
// }