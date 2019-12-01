import 'package:flutter/material.dart';
import 'package:timer_tracker/services/auth.dart';

class AuthProvider extends InheritedWidget {
  final AuthBase auth;
  final Widget child;
  AuthProvider({
    @required this.auth,
    @required this.child,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context) {
    AuthProvider provider = context.inheritFromWidgetOfExactType(AuthProvider);
    return provider.auth;
  }
}
