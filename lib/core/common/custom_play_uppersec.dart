import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/theme/pallete.dart';

// ignore: must_be_immutable
class CustomPlayUpperSec extends StatelessWidget {
  final Size size;
  final Color color;
  final String title;
  final void Function() onsearchTap;
  CustomPlayUpperSec(
      {Key? key,
      required this.size,
      required this.color,
      required this.title,
      required this.onsearchTap})
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
                  onPressed: onsearchTap,
                  icon: Icon(
                    Icons.search,
                    color: const Color.fromARGB(255, 145, 145, 145),
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
