import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserCredential> login({
    @required String email,
    String password,
  }) {
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .asStream();
  }
}
