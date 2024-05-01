import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../theme/pallete.dart';

class CustomMaterialButton extends StatelessWidget {
  final Color color;
  final Size size;
  final String title;
  const CustomMaterialButton(
      {super.key,
      required this.color,
      required this.size,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(size.width * 0.02),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(size.width * 0.02),
                bottomRight: Radius.circular(size.width * 0.02))),
        height: size.height * 0.06,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontFamily: "Muller",
                    color: Pallete.whiteColor,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
