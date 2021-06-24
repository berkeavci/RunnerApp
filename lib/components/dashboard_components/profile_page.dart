import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class userProfile_Page extends StatefulWidget {
  userProfile_Page({Key? key}) : super(key: key);

  @override
  userProfile_PageState createState() => userProfile_PageState();
}

class userProfile_PageState extends State<userProfile_Page> {
  var userInformation = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var user = userInformation!;
    var email = user.email;
    return Container(
      child: Row(
        children: [Text(" Email of Profile -> " + email!)],
      ),
    );
  }
}
