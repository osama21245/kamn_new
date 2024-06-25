import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomPlayUpperSecLogo extends StatelessWidget {
  final Size size;
  final Color color;
  final String title;
  final void Function() onLogoTap;
  CustomPlayUpperSecLogo(
      {Key? key,
      required this.size,
      required this.color,
      required this.title,
      required this.onLogoTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.02,
          top: size.width * 0.02,
          right: size.width * 0.024),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: size.width * 0.05,
                  ),
                  onPressed: () => Get.back()),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/page-1/images/kamn_noBG.png",
                    width: size.width * 0.1,
                    fit: BoxFit.contain,
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$title',
                    style: TextStyle(
                        color: color,
                        fontFamily: "Inter",
                        fontSize: size.width * 0.049,
                        fontWeight: FontWeight.w800,
                        height: -size.height * 0.0002),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.09,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
