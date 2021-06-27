import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runner/components/dashboard_components/profile_page.dart';
import 'package:runner/constans.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();

  // TODO:Handle Better User across Application

  var userInformation = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.navigate_before_outlined,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.cloud_download,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          nameTF(nameController, cityController, aboutController),
        ],
      ),
    );
  }
}

// Name chage TF

Widget nameTF(
        TextEditingController nameController,
        TextEditingController cityController,
        TextEditingController aboutController) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              TextField(
                controller: nameController
                  ..text = userInformation!.displayName ?? "",
                cursorColor: thePrimaryColor,
                decoration: InputDecoration(
                    icon: Icon(CupertinoIcons.person_crop_rectangle,
                        color: thePrimaryColor),
                    hintText: 'Your name and surname'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: cityController,
                cursorColor: thePrimaryColor,
                decoration: InputDecoration(
                    icon: Icon(Icons.flight_land, color: thePrimaryColor),
                    hintText: 'Your City'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: cityController,
                cursorColor: thePrimaryColor,
                decoration: InputDecoration(
                  icon:
                      Icon(Icons.account_box_outlined, color: thePrimaryColor),
                  hintText: 'Edit About Me',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ],
    );

// TODO: City and About me comes from Sqlite or Firebase, Add cascade when done to here
