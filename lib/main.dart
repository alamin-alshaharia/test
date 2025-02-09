import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';

void main() {
  runApp(AlarmApp());
}

class AlarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlarmScreen(),
    );
  }
}

class AlarmScreen extends StatelessWidget {
  // Method to attempt opening the clock app or setting an alarm
  Future<bool> openClockApp() async {
    try {
      // Try to open the clock app using URL schemes
      const url = 'clock://'; // Common URL scheme for clock apps
      if (await canLaunch(url)) {
        await launch(url);
        return true;
      }

      // Fallback to Android Intent for setting alarms
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.SET_ALARM',
        arguments: {
          'android.intent.extra.alarm.HOUR': 8, // Set the hour (24-hour format)
          'android.intent.extra.alarm.MINUTES': 30, // Set the minutes
          'android.intent.extra.alarm.SKIP_UI': false, // Show the UI
        },
      );

      await intent.launch();
      return true;
    } catch (e) {
      print('Error launching clock app: $e');
    }

    return false; // No supported clock app found
  }

  // Method to show an error dialog if the clock app cannot be opened
  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(
            'Could not open the clock app. Please set the alarm manually.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Alarm'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool success = await openClockApp();
            if (!success) {
              showErrorDialog(context);
            }
          },
          child: Text('Open Clock App'),
        ),
      ),
    );
  }
}