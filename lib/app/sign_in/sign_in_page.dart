import 'package:flutter/material.dart';
import 'package:timer_tracker/app/sign_in/email_sign_in.dart';
import 'package:timer_tracker/app/sign_in/sign_in_button.js.dart';
import 'package:timer_tracker/app/sign_in/social_sign_in_button.dart';

import 'package:timer_tracker/services/auth.dart';
import 'package:timer_tracker/services/auth_provider.dart';

class SignInPage extends StatelessWidget {

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
    final auth = AuthProvider.of(context);
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    //TODO: Sign in with email
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) =>  EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: "Sign in with Google",
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: "Sign in with Facebook",
            textColor: Colors.white,
            color: Color(0XFF334D92),
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Sign in with Email",
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'or',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Go Anonymous",
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
