import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runner/LoginStates/google_signIn.dart';
import 'package:provider/provider.dart';
import 'package:runner/components/inputEmail_TF.dart';
import 'package:runner/components/inputPassword_TF.dart';
import 'package:runner/components/input_container.dart';

Widget _buildLoginBtn(BuildContext ct) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.red,
          minimumSize: Size(50, 50)),
      icon: FaIcon(FontAwesomeIcons.google),
      label: Text('Login via Google'),
      onPressed: () {
        var provider = Provider.of<GoogleSignInProvider>(ct, listen: false);
        provider.googleLogin(); // Through provider, we call googleLogin()
      },
    ),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                width: 500,
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        "./assets/images/logoimage.png",
                        width: 85,
                        height: 85,
                      ),
                    ),
                    SizedBox(
                      height: 31,
                    ),
                    Text(
                      'Welcome Back to Runner Tracker',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    InputEmailTF(),
                    InputPasswordTF(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
