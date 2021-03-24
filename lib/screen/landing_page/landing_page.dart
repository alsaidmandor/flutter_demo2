import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/screen/app_sign_in/sign_in_page.dart';
import 'package:flutter_demo2/screen/homePage/home_page.dart';
import 'file:///E:/Programming/Courses/FlutterProjects/flutter_demo2/lib/screen/homePage/jobs/job_page.dart';
import 'package:flutter_demo2/services/Database.dart';
import 'package:flutter_demo2/services/auth.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
  return  StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<Database>(
                create: (_) => FireStoreDatabase(uid: user.uid),
                child: HomePage( ));
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        });
  }


}
