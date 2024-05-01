import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/pallete.dart';

isDateTwoDaysApart(DateTime date, void Function() trueConditionFunction,
    Size size, BuildContext context) {
  final now = DateTime.now();
  final difference = date.difference(now).inDays;
  if (difference <= 2) {
    AwesomeDialog(
      dialogBackgroundColor: Color.fromARGB(255, 240, 240, 240),
      barrierColor: Color.fromARGB(108, 26, 26, 26),
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
            ' because you exceeded the specified time limit of two days before the appointment , so you cant cancle your reservision , if you want to cancle \n call ground owner',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Muller",
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OK',
                  style: TextStyle(
                      color: Pallete.whiteColor,
                      fontFamily: "Muller",
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.3, size.height * 0.04),
                backgroundColor: Pallete.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.02))),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
        ],
      ),
    )..show();
  } else {
    trueConditionFunction();
  }
}
