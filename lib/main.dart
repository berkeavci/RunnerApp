import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runner/Page/MainPageNavigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:theme_provider/theme_provider.dart';
import 'LoginStates/google_signIn.dart';
import 'package:provider/provider.dart';
import 'package:runner/LoginStates/sign_in_withoutGoogle.dart';

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Needed for running any code before running application

  await Firebase.initializeApp();

  runApp(RunnerTracker());
}

class RunnerTracker extends StatelessWidget {
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: [
        AppTheme.light(),
        AppTheme.dark(),
      ],
      child: ThemeConsumer(
        child: ChangeNotifierProvider(
          create: (_) => GoogleSignInProvider(),
          child: Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth
                .instance), //TODO: Divide this area with theme change
            child: Builder(
              builder: (context) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Runner Tracker',
                theme: ThemeProvider.themeOf(context).data,
                home: MainPageNavigator(),
              ),
            ),
          ),
        ),
      ),
    );
  } // Return widget - view
}
