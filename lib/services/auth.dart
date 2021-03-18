import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase
{
  User get currentUser ;
  Stream<User> authStateChanges();
  Future <User> signInAnonymously() ;
  Future<Void> signOut() ;
}

// class Auth raper for FirebaseAuth .
class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

@override
  User get currentUser => _firebaseAuth.currentUser ;

  @override
  Future <User> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Void> signOut() async
  {
    await _firebaseAuth.signOut() ;
  }
}
