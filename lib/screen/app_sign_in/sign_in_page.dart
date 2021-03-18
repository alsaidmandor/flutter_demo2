import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/custom_raisdbutton.dart';
import 'package:flutter_demo2/screen/app_sign_in/sign_in_button.dart';
import 'package:flutter_demo2/screen/app_sign_in/social_sign_in_button.dart';
import 'package:flutter_demo2/services/auth.dart';

class SignInPage extends StatelessWidget {

  const SignInPage({Key key, @required this.onSignIn, @required this.auth}) : super(key: key);

  // callback user
  final void Function(User) onSignIn ;
  final AuthBase auth ;

  void _signInAnonymously() async
  {
    try{
            final user = await auth.signInAnonymously();
            onSignIn(user);
      }catch(e)
    {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // shortcut => extend selection => ctrl + arrow up + press button W
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Time Tracker',
        ),
        centerTitle: true, // this is all you need
        elevation: 2.0,
      ),
      body: _buildContent(),
    );
  }

// private
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            // ignore: deprecated_member_use
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              txt: "Sign in with Google",
              onPressed: () {},
              txtColor: Colors.black87,
              color: Colors.white,
            ),
            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              txt: "Sign in with Facebook",
              onPressed: () {},
              txtColor: Colors.black87,
              color: Color(0xFF334D92),
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              txt: "Sign in with email",
              onPressed: () {},
              color: Colors.teal,
            ),
            SizedBox(height: 8.0,)
            ,
            Text(
              'or',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              txt: "Go anonymous",
              onPressed: _signInAnonymously,
              color: Colors.lime[300],
            ),

/*
            CustomRaisedButton(
              child: Text(
                'Sign in with Facebook',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black87,
                ),
              ),
              color: Colors.white,
              borderRadius: 4.0,
              onPressed: (){},
            ),
*/
          ],
        ),
      ),
    );
  }

  void _signInWithGoogle() {
    // TODO: Auth with Google
  }
}
