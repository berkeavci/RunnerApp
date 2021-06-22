import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner/LoginStates/google_signIn.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';

// Application DashBoard Page
class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(user?.email ?? "Error?!" + "has logged in!"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                var provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              child: Text("Logout"),
            )
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Row(
            children: [
              GoogleMapsView(),
            ],
          ),
        ),
      );
}
