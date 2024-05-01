import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/screens/login_screen.dart';

import '../../featuers/payment/screens/toggle_screen.dart';
import '../../models/passorder_model.dart';
import '../../theme/pallete.dart';

checkAuth(PassOrderModel passOrderModel, String collection,
    BuildContext context, bool isAuth, Size size) {
  if (isAuth == true) {
    Get.to(() => ToggleScreen(
          collection: collection,
          passOrderModel: passOrderModel,
        ));
  } else {
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
            'Thats a Demo Version of the App \n but if you want to see this future \n login first',
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
            onPressed: () => Get.to(LoginScreen()),
            child: Row(
              children: [
                Image.asset(
                  "assets/page-1/images/kamn_splash.png",
                  fit: BoxFit.contain,
                ),
                Text(
                  'Register Now',
                  style: TextStyle(
                      color: Pallete.whiteColor,
                      fontFamily: "Muller",
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.6, size.height * 0.04),
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
  }
}
