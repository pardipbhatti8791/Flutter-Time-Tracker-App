import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_tracker/app/sign_in/email_sign_in_bloc.dart';
import 'package:timer_tracker/app/sign_in/email_sign_in_change_model.dart';
import 'package:timer_tracker/app/sign_in/email_sign_in_model.dart';
import 'package:timer_tracker/common_widgets/form_submit_button.dart';
import 'package:timer_tracker/common_widgets/platform_exception_alert_dialog.dart';
import 'package:timer_tracker/services/auth.dart';
import 'package:flutter/services.dart';

class EmailSignInChangeNotifier extends StatefulWidget {
  EmailSignInChangeNotifier({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      // ignore: deprecated_member_use
      builder: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) => EmailSignInChangeNotifier(
          model: model,
        ),
      ),
    );
  }

  @override
  _EmailSignInChangeNotifierState createState() =>
      _EmailSignInChangeNotifierState();
}

class _EmailSignInChangeNotifierState extends State<EmailSignInChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<void> _submit() async {
    try {
      await widget.model.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (error) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed!',
        exception: error,
      ).show(context);
    }
  }

  void _toggleFormType() {
    widget.model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete() {
    final newFocus = widget.model.emailValidator.isValid(widget.model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 16.0,
      ),
      FormSubmitButton(
        text: widget.model.primaryBtnText,
        onPressed: widget.model.canSubmit ? _submit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        child: Text(
          widget.model.secondaryBtnText,
        ),
        onPressed: !widget.model.isLoading ? _toggleFormType : null,
      )
    ];
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "example@gmail.com",
        errorText: widget.model.emailErrorText,
        enabled: widget.model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEditingComplete(),
      onChanged: widget.model.updateEmail,
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "password",
        errorText: widget.model.invalidPasswordErrorText,
        enabled: widget.model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
      onChanged: widget.model.updatePassword,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
