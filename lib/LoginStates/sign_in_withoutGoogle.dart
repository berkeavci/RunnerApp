import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      print("pas: " + password + "email: " + email);
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_firebaseAuth.currentUser?.uid);
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Successfull!");
      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future logoutUser() async {
    _firebaseAuth.signOut();
  }
}
