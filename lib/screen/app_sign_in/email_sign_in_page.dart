import 'package:flutter/material.dart';
import 'package:flutter_demo2/screen/app_sign_in/email_sign_in_change_notifier_base.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Time Tracker',
        ),
        centerTitle: true, // this is all you need
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormChangeNotifierBase.create(context),
          ),
        ),
      ),
    );
  }
}
