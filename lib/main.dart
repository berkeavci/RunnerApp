import 'package:flutter/material.dart';
import 'package:runner/Page/firstpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LoginStates/google_signIn.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Needed for running any code before running application

  await Firebase.initializeApp();

  runApp(RunnerTracker());
}

class RunnerTracker extends StatelessWidget {
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Runner Tracker',
        theme: ThemeData(
          primaryColor: Colors.red.shade400,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: FirstPage(),
      )); // Return widget - view

}
