
import 'package:flutter/material.dart';
import 'package:timer_tracker/common_widgets/platform_alert_dialog.dart';
import 'package:timer_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.auth});
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignout = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    print(didRequestSignout);
    if(didRequestSignout == true) {
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
    );
  }
}
