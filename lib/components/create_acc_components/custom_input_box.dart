import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomInputBox extends StatefulWidget {
  final String label;
  final String inputHint;
  final IconData iconHolder;
  final TextEditingController controller;
  CustomInputBox({
    Key? key,
    required this.label,
    required this.inputHint,
    required this.iconHolder,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomInputBoxState createState() => _CustomInputBoxState();
}

class _CustomInputBoxState extends State<CustomInputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 8),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.label == 'Password' ? true : false,
            onEditingComplete: () {},
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              hintText: widget.inputHint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
                fontSize: 19,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              focusColor: Colors.orange,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black),
                  gapPadding: 5),
              prefixIcon: Icon(widget.iconHolder, size: 17, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
