import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/show_alert_dialog.dart';
import 'package:flutter_demo2/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_demo2/models/job.dart';
import 'package:flutter_demo2/screen/homePage/job_list_tile.dart';
import 'package:flutter_demo2/screen/homePage/edit_job_page.dart';
import 'package:flutter_demo2/services/Database.dart';
import 'package:flutter_demo2/services/auth.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
  void _signOt(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you that you want to logout ?',
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
    print(didRequestSignOut.toString());
    if (didRequestSignOut == true) {
      _signOt(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        centerTitle: true, // this is all you need
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditJobPage.show(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<DataBase>(context);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            final jobs = snapShot.data;
            final children = jobs
                .map((job) => JobListTile(
                      job: job,
                      onTap: () => EditJobPage.show(context, job: job),
                    ))
                .toList();
            return ListView(children: children);
          }

          if (snapShot.hasError) {
            return Center(
              child: Text('Some error occurred'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
