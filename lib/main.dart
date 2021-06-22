import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runner/Page/MainPageNavigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LoginStates/google_signIn.dart';
import 'package:provider/provider.dart';
import 'constans.dart';
import 'package:runner/LoginStates/sign_in_withoutGoogle.dart';

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Needed for running any code before running application

  await Firebase.initializeApp();

  runApp(RunnerTracker());
}

class RunnerTracker extends StatelessWidget {
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => GoogleSignInProvider(),
        child: Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Runner Tracker',
            theme: ThemeData(
              primaryColor: thePrimaryColor,
              textTheme:
                  GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
            ),
            home: MainPageNavigator(),
          ),
        ),
      ); // Return widget - view

}
