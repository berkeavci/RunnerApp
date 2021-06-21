import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runner/LoginStates/google_signIn.dart';
import 'package:provider/provider.dart';

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

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          "./assets/images/logoimage.png",
          alignment: Alignment.bottomCenter,
        ),
        _buildLoginBtn(context),
      ],
    );
  }
}
