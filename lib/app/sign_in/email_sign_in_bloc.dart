import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:timer_tracker/app/sign_in/email_sign_in_model.dart';
import 'package:timer_tracker/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  EmailSignInModel _model = EmailSignInModel();

  final StreamController<EmailSignInModel> _signInModelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get signInModelStream =>
      _signInModelController.stream;

  void dispose() {
    _signInModelController.close();
  }

  ///
  Future<void> submit() async {
    updateWith(
      submitted: true,
      isLoading: true,
    );
    try {
      if (_model.formType == EmailSignInType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (error) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  /// toggleFormType
  void toggleFormType() {
    final formType = _model.formType == EmailSignInType.signIn
        ? EmailSignInType.register
        : EmailSignInType.signIn;

    updateWith(
      email: '',
      password: '',
      submitted: false,
      isLoading: false,
      formType: formType,
    );
  }

  void updateWith({
    String email,
    String password,
    EmailSignInType formType,
    bool isLoading,
    bool submitted,
  }) {
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    _signInModelController.add(_model);
  }
}
