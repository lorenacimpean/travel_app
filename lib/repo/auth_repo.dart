import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserCredential> login(String email, String password) {
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .asStream();
  }
}
