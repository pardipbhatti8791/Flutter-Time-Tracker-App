import 'package:flutter/material.dart';
import 'package:timer_tracker/app/landing_page.dart';
import 'package:timer_tracker/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      // ignore: deprecated_member_use
      builder: (context) => Auth(),
      child: MaterialApp(
        title: "Time Tracker App",
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
