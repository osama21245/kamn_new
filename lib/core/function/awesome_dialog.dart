import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

showAwesomeDialog(BuildContext context, String name, Size size) {
  return AwesomeDialog(
    dialogBackgroundColor: const Color.fromARGB(255, 231, 230, 230),
    barrierColor: const Color.fromARGB(108, 255, 255, 255),
    context: context,
    animType: AnimType.scale,
    dialogType:
        DialogType.noHeader, // Use NO_HEADER to remove the default header
    body: Column(
      children: [
        Image.asset(
          'assets/page-1/images/kamn_noBG.png', // Replace with the path to your custom image
          width: size.width * 0.5,
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Muller",
              color: Color.fromARGB(255, 36, 36, 36),
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
      ],
    ),
  )..show();
}
