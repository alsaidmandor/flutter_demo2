import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/screen/app_sign_in/sign_in_page.dart';
import 'package:flutter_demo2/screen/homePage/home_page.dart';
import 'package:flutter_demo2/services/auth.dart';

class LandingPage extends StatelessWidget {

  const LandingPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
  return  StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: auth,
              );
            }
            return HomePage(
              auth: auth,
            );
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        });
  }


}
