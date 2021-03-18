import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/screen/app_sign_in/sign_in_page.dart';
import 'package:flutter_demo2/screen/homePage/home_page.dart';
import 'package:flutter_demo2/services/auth.dart';

class LandingPage extends StatefulWidget {

  const LandingPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  void _updateUser(User user) {
    setState(() {
      widget.auth.authStateChanges().listen((user) {
        print('Uid : ${user?.uid}');
      });
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
  return  StreamBuilder<User>(
        stream: widget.auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return SignInPage(
                onSignIn: (user) => _updateUser(user),
                auth: widget.auth,
              );
            }
            return HomePage(
              onSignOut: () => _updateUser(null),
              auth: widget.auth,
            );
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        });
  }
}
