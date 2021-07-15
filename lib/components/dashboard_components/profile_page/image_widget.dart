import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String image;

  const ImageWidget({
    Key? key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: AssetImage(image),
                fit: BoxFit.cover,
                width: 128,
                height: 128,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(0.5),
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.red.shade300,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black,
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
