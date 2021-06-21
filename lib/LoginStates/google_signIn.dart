import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  var googlesignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!; // returns _user to user

  Future googleLogin() async {
    // signIn operation begins - Pop-up shows up
    try {
      var googleUser = await googlesignIn.signIn();
      if (googleUser == null) return ("Login Through Gmail has failed!");
      _user = googleUser;

      var googleAuth = await googleUser.authentication;

      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future logout() async {
    await googlesignIn.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
