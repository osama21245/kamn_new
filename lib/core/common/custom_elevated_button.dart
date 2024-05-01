import 'package:flutter/material.dart';

import '../../theme/pallete.dart';

class CustomElevatedButton extends StatelessWidget {
  final Size size;
  final String title;
  final double sizeofwidth;
  final double sizeofhight;
  final void Function() onTap;
  final Color color;
  const CustomElevatedButton(
      {Key? key,
      required this.size,
      required this.color,
      required this.title,
      required this.sizeofwidth,
      required this.sizeofhight,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
            color: Pallete.whiteColor,
            fontFamily: "Muller",
            fontSize: size.width * 0.05,
            fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
          fixedSize: Size(sizeofwidth, sizeofhight),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width * 0.02))),
    );
  }
}
