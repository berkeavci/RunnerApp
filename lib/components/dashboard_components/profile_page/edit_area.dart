import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runner/components/dashboard_components/profile_page.dart';
import 'package:runner/constans.dart';
import 'package:runner/entities/user.dart';

class EditProfile extends StatefulWidget {
  final UserInformations? userInfo;

  EditProfile({Key? key, required this.userInfo}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();

  // TODO:Handle Better User across Application

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.cloud_download,
              color: Colors.black,
            ),
            onPressed:
                () {}, // TODO: Save button which inserts data to DB in any change.
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
          nameTF(nameController, cityController, aboutController,
              widget.userInfo?.name ?? "No Name"),
        ],
      ),
    );
  }
}

// Name chage TF

Widget nameTF(
        TextEditingController nameController,
        TextEditingController weightController,
        TextEditingController aboutController,
        String userInfo) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              TextField(
                controller: nameController..text = userInfo,
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
                controller: weightController,
                cursorColor: thePrimaryColor,
                decoration: InputDecoration(
                    icon: Icon(FontAwesomeIcons.fire, color: thePrimaryColor),
                    hintText: 'Your City'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: aboutController,
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
