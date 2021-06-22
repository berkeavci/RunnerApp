import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constans.dart';
import 'input_container.dart';

class InputPasswordTF extends StatelessWidget {
  const InputPasswordTF({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        controller: passwordController,
        cursorColor: thePrimaryColor,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: thePrimaryColor,
          ),
          hintText: 'Password',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
