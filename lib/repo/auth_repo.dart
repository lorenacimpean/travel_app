import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserCredential> login({
    @required String email,
    @required String password,
  }) {
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .asStream();
  }

  Stream<UserCredential> signUp({
    @required String email,
    @required String password,
  }) {
    return _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .asStream();
  }
}
