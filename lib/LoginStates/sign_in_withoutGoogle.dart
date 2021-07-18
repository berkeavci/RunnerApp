import 'package:firebase_auth/firebase_auth.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      print("pas: " + password + "email: " + email);
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // .then(
      //   (value) => ApplicationState()
      //       .addUsertoDatabase(value.user?.displayName)
      //       .onError(
      //         (error, stackTrace) => print(
      //           error.toString(),
      //         ),
      //       ),
      // );
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
