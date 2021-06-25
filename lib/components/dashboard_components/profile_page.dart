import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner/LoginStates/google_signIn.dart';
import 'package:runner/components/dashboard_components/profile_page_components/image_widget.dart';

// Profile Page of User - View

var userInformation = FirebaseAuth.instance.currentUser;

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var icon = CupertinoIcons.moon_stars; // Dark/Night mode change button
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.navigate_before_outlined),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              var provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("./assets/images/appbar_background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text("Profile"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ImageWidget(image: "./assets/images/avatar_images.jpeg"),
          SizedBox(
            height: 30,
          ),
          Information(),
        ],
      ),
    );
  }
}

Widget Information() => Column(
      children: [
        Text(
          '${userInformation!.displayName}',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
