import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomUpdateGalleryUpperSec extends StatelessWidget {
  final Size size;
  final Color color;
  final String title;
  final void Function() ontap;
  const CustomUpdateGalleryUpperSec(
      {Key? key,
      required this.size,
      required this.color,
      required this.title,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.05,
          top: size.width * 0.08,
          right: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: ontap,
            child: CircleAvatar(
              radius: size.width * 0.045,
              backgroundColor: color,
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '$title',
              style: TextStyle(
                color: color,
                fontFamily: "Muller",
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.09,
          )
        ],
      ),
    );
  }
}
