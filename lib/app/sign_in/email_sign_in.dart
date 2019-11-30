import 'package:flutter/material.dart';
import 'package:timer_tracker/app/sign_in/email_sign_in_form.dart';
import 'package:timer_tracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({ this.auth });
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(child: EmailSignInForm(auth: auth)),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
