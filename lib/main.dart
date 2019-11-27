import 'package:flutter/material.dart';
import 'package:timer_tracker/app/landing_page.dart';
import 'package:timer_tracker/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Time Tracker App",
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: LandingPage(
          auth: Auth(),
        ));
  }
}
