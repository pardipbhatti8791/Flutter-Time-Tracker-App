import 'package:flutter/material.dart';
import 'package:timer_tracker/common_widgets/form_submit_button.dart';
import 'package:timer_tracker/services/auth.dart';

enum EmailSignInType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.auth});

  final AuthBase auth;
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EmailSignInType _formType = EmailSignInType.signIn;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async {
    if(_formType == EmailSignInType.signIn) {
      await widget.auth.signInWithEmailAndPassword(_email, _password);
    } else {
      await widget.auth.createUserWithEmailAndPassword(_email, _password);
    }
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInType.signIn
          ? EmailSignInType.register
          : EmailSignInType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailSignInType.signIn ? 'Sign in' : 'Create an account';
    final secondaryText = _formType == EmailSignInType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "example@gmail.com",
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "password",
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 16.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: _submit,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        child: Text(
          secondaryText,
        ),
        onPressed: _toggleFormType,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
}
