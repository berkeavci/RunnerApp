import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runner/LoginStates/google_signIn.dart';
import 'package:provider/provider.dart';
import 'package:runner/LoginStates/sign_in_withoutGoogle.dart';
import 'package:flutter/foundation.dart';
import 'package:runner/Page/create_account_page.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';
import 'package:runner/components/loginpage/inputEmail_TF.dart';
import 'package:runner/components/loginpage/inputPassword_TF.dart';
import 'package:runner/entities/user.dart';

import '../constans.dart';

Widget _buildLoginBtn(BuildContext ct) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: 350,
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

Widget _buildSignInButton(
    BuildContext ct,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return Container(
    width: 350,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          primary: Colors.white, minimumSize: Size(50, 50)),
      icon: FaIcon(
        Icons.login,
        color: Colors.red,
      ),
      onPressed: () {
        var providerR = Provider.of<AuthenticationService>(ct, listen: false);
        providerR
            .signIn(
                email: emailController.text, password: passwordController.text)
            .then((value) {
          if (value != 'Signed Up') {
            // ApplicationState().fetchUserInformation().then((value) {
            //   ApplicationState()
            //       .addUserLeaderboardInfo(value?.name)
            //       .onError((error, stackTrace) => print("${error.toString()}"));
            //   print(value?.name);
            // });

            // TODO: deal w/mounted
            ScaffoldMessenger.of(ct)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    '${value.toString()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: productSans,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              );
          }
        });
      },
      label: Text(
        "Login",
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

@override
Widget _buildCreateAccountButton(BuildContext context) {
  return TextButton(
    child: Text(
      "Create an account",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CreateAnAccountPage(),
        ),
      );
    },
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? name;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                width: width,
                height: height,
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
                    InputEmailTF(
                      emailController: emailController,
                    ),
                    InputPasswordTF(
                      passwordController: passwordController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildSignInButton(
                        context, emailController, passwordController),
                    _buildLoginBtn(context),
                    _buildCreateAccountButton(context),
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
