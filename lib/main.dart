// Importing important packages require to connect
// Flutter and Dart
import 'package:flutter/material.dart';

// Main Function
void main() {
  // Giving command to runApp() to run the app.

  /* The purpose of the runApp() function is to attach
the given widget to the screen. */
  runApp(const MyApp());
}

// Widget is used to create UI in flutter framework.

/* StatelessWidget is a widget, which does not maintain
any state of the widget. */

/* MyApp extends StatelessWidget and overrides its
build method. */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(title: 'Home page'));
  }
}

void startAnalyze() {}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(''),
            FilledButton(
              onPressed: startAnalyze,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Listen"), Icon(Icons.audiotrack)],
              ),
            ),
            Text('time/time sample length'),
          ],
        ),
      ),
    );
  }
}
