import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../theme/pallete.dart';
import '../constants/imgaeasset.dart';

class NoDataAnimation extends StatelessWidget {
  final Size size;
  const NoDataAnimation({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          fit: BoxFit.contain,
          AppImageAsset.nodata,
          repeat: true,
        ),
        Text(
          "There is no orders yet",
          style: TextStyle(
            color: Pallete.lightgreyColor2,
            fontFamily: "Muller",
            fontSize: size.width * 0.055,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
