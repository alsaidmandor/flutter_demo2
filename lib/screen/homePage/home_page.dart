import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/show_alert_dialog.dart';
import 'package:flutter_demo2/services/auth_provider.dart';

class HomePage extends StatelessWidget {


  void _signOt(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
        context,
        title: 'Logout',
        content: 'Are you that you want to logout ?',
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
print(didRequestSignOut.toString());
    if(didRequestSignOut == true)
      {
        _signOt(context) ;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          TextButton(
            onPressed:() => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }
}
