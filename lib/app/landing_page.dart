import 'package:flutter/material.dart';
import 'package:timer_tracker/app/home_page.dart';
import 'package:timer_tracker/app/sign_in/sign_in_page.dart';
import 'package:timer_tracker/services/auth.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            print("here");
            return SignInPage(
              auth: auth,
            );
          }

          return HomePage(
            auth: auth,
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
