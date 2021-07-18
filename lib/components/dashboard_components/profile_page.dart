import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner/LoginStates/google_signIn.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';
import 'package:runner/components/dashboard_components/profile_page/edit_area.dart';
import 'package:runner/components/dashboard_components/profile_page/image_widget.dart';
import 'package:runner/entities/user.dart';
import 'package:theme_provider/theme_provider.dart';

// Profile Page of User - View

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // var icon = (userInformation?.isAnonymous ?? false)
  //     ? CupertinoIcons.moon_stars
  //     : CupertinoIcons.moon_stars_fill;
  // TODO: change userInformation.isAnonymous w/ UserPreference change

  UserInformations? userInformation;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      ApplicationState().fetchUserInformation().then((value) => setState(() {
            userInformation = value;
            print(value?.map["email"]);
          }));
    }
  }

  var icon = CupertinoIcons.moon_stars;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus
          ?.unfocus(), // Close Keyboard on IOS
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(icon),
            onPressed: () {
              ThemeProvider.controllerOf(context).nextTheme();
            },
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                var provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider
                    .logout()
                    .onError((error, stackTrace) => print(error.toString()));
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
            informationArea(userInformation),
            SizedBox(
              height: 30,
            ),
            buttonWidget(context, userInformation),
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
Widget informationArea(UserInformations? uI) => Column(
      children: [
        Text(
          '${uI?.map["name"] ?? "Empty"}',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${uI?.email ?? "Empty"}',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
        )
      ],
    );

// Edit Button
Widget buttonWidget(BuildContext ct, UserInformations? ui) => Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red.shade300,
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
              MaterialPageRoute(
                  builder: (context) => EditProfile(userInfo: ui)),
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
