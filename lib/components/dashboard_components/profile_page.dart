import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner/LoginStates/google_signIn.dart';
import 'package:runner/components/dashboard_components/profile_page/edit_area.dart';
import 'package:runner/components/dashboard_components/profile_page/image_widget.dart';

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus
          ?.unfocus(), // Close Keyboard on IOS
      child: Scaffold(
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
            SizedBox(
              height: 10,
            ),
            ImageWidget(image: "./assets/images/avatar_images.jpeg"),
            SizedBox(
              height: 30,
            ),
            informationArea(),
            SizedBox(
              height: 30,
            ),
            buttonWidget(context),
            SizedBox(
              height: 30,
            ),
            aboutMe(context),
          ],
        ),
      ),
    );
  }
}

//  Email + NameandSurname
Widget informationArea() => Column(
      children: [
        Text(
          '${userInformation!.displayName}',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${userInformation!.email}',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
        )
      ],
    );

// Button MaterialState Color Transition
// Color? getColor(Set<MaterialState> states) {
//   const Set<MaterialState> interactiveStates = <MaterialState>{
//     MaterialState.pressed,
//     MaterialState.hovered,
//     MaterialState.focused,
//   };
//   if (states.any((value) => interactiveStates.contains(value))) {
//     return Colors.yellow;
//   } else {
//     return Colors.red;
//   }
// }

// Edit Button
Widget buttonWidget(BuildContext ct) => Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red.shade100,
            elevation: 1,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(CupertinoIcons.arrow_up_right_circle),
            ],
          ),
          onPressed: () {
            Navigator.push(
              ct,
              MaterialPageRoute(builder: (context) => EditProfile()),
            );
          },
        ),
      ],
    );

// About Me Area
// TODO: Scrollable TextField()
Widget aboutMe(BuildContext ct) => Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(''), // -> User aboutme Data // Fetch from sqllite
          ],
        ),
      ),
    );
