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
                padding: EdgeInsets.all(2),
                child: Container(
                  padding: EdgeInsets.all(11),
                  color: Colors.blue,
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
          )
        ],
      ),
    );
  }
}
