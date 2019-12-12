import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timer_tracker/app/home/models/job.dart';
import 'package:timer_tracker/common_widgets/platform_alert_dialog.dart';
import 'package:timer_tracker/common_widgets/platform_exception_alert_dialog.dart';
import 'package:timer_tracker/services/auth.dart';
import 'package:timer_tracker/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
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
    if (didRequestSignout == true) {
      _signOut(context);
    }
  }

  Future<void> _createJob(BuildContext context) async {
    try {
      final database = Provider.of<Database>(context);
      await database.createJob(
        Job(
          name: 'Flutter New Course',
          ratePerHour: 20,
        ),
      );
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(title: 'Operation failed', exception: e)
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    db.jobsStream();
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
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
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createJob(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final databse = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: databse.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          final children = jobs.map((job) => Text(job.name)).toList();
          return ListView(
            children: children,
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
