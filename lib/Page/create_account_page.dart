import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runner/LoginStates/sign_in_withoutGoogle.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';
import 'package:runner/components/create_acc_components/custom_input_box.dart';
import '../constans.dart';

class CreateAnAccountPage extends StatefulWidget {
  CreateAnAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAnAccountPageState createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      top: 80,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                CustomInputBox(
                  label: "Name",
                  inputHint: "Berke Can Avci",
                  iconHolder: FontAwesomeIcons.user,
                  controller: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInputBox(
                  label: "Email",
                  inputHint: "example@example.com",
                  iconHolder: FontAwesomeIcons.at,
                  controller: emailController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInputBox(
                  label: "Password",
                  inputHint: "6+ Characters",
                  iconHolder: FontAwesomeIcons.key,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 20,
                ),
                AgreeText(),
                SizedBox(
                  height: 20,
                ),
                CreateanAccountButton(
                  width: width,
                  emailController: emailController,
                  passwordController: passwordController,
                  nameController: nameController,
                ),
                SignInTextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignInTextButton extends StatelessWidget {
  const SignInTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              color: Colors.grey.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: productSans,
            ),
          ),
          TextSpan(
            text: 'Sign In',
            style: TextStyle(
              fontFamily: productSans,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}

class CreateanAccountButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  const CreateanAccountButton({
    Key? key,
    required this.width,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
  }) : super(key: key);

  final double width;

  @override
  _CreateanAccountButtonState createState() => _CreateanAccountButtonState();
}

class _CreateanAccountButtonState extends State<CreateanAccountButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: widget.width * 0.85,
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      height: 75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          primary: Colors.red,
        ),
        onPressed: () {
          var providerCreate = Provider.of<AuthenticationService>(
            context,
            listen: false,
          );
          providerCreate
              .signUp(
                  email: widget.emailController.text,
                  password: widget.passwordController.text)
              .then((value) {
            if (value == 'Signed Up') {
              ApplicationState().addUsertoDatabase(widget.nameController.text);
              ApplicationState()
                  .addUserLeaderboardInfo(widget.nameController.text);
              if (mounted) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Successfull Sign Up!'),
                    ),
                  );
              }
              Navigator.pop(context, widget.nameController.text);
            } else {
              if (mounted) {
                ScaffoldMessenger.of(context)
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
            }
          });
        },
        child: Text("Create an Account"),
      ),
    );
  }
}

class AgreeText extends StatelessWidget {
  const AgreeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
      child: Text(
        'By creating account, you are agreeing our Terms of Service and Conditions',
        style: TextStyle(
          color: Colors.grey.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
