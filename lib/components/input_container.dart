import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constans.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: thePrimaryColor.withAlpha(70)),
      child: child,
    );
  }
}
