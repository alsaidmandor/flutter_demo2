import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_demo2/screen/app_sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter_demo2/screen/app_sign_in/email_sign_in_page.dart';
import 'package:flutter_demo2/screen/app_sign_in/sign_in_button.dart';
import 'package:flutter_demo2/screen/app_sign_in/social_sign_in_button.dart';
import 'package:flutter_demo2/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.bloc}) : super(key: key);

  final SignInBloc bloc ;


  static Widget create (BuildContext context)
  {
    return Provider<SignInBloc>(
        create: (_) => SignInBloc() ,
      child: Consumer<SignInBloc>(builder:(_ , bloc, __) => SignInPage(bloc: bloc,)),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == "ERROR_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign In Failed',
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);

      auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      auth.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
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
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          return _buildContent(context , snapshot.data);
        }
      ),
    );
  }

  Widget _buildContent(BuildContext context , bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50.0, child: _buildHeader(isLoading)),
            SizedBox(
              height: 48.0,
            ),
            // ignore: deprecated_member_use
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              txt: "Sign in with Google",
              onPressed: isLoading ? null : () => _signInWithGoogle(context),
              txtColor: Colors.black87,
              color: Colors.white,
            ),
            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              txt: "Sign in with Facebook",
              onPressed: isLoading ? null : () => _signInWithFacebook(context),
              txtColor: Colors.black87,
              color: Color(0xFF334D92),
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              txt: "Sign in with email",
              onPressed: isLoading ? null : () => _signInWithEmail(context),
              color: Colors.teal,
            ),
            SizedBox(
              height: 8.0,
            ),
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
              onPressed: isLoading ? null : () => _signInAnonymously(context),
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

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
