import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runner/components/input_container.dart';
import '../constans.dart';

class InputEmailTF extends StatelessWidget {
  const InputEmailTF({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        cursorColor: thePrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: thePrimaryColor,
          ),
          hintText: 'Username',
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// Above widget return InputContainer so that it connects with it and became much cleaner code.
