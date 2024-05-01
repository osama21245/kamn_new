import 'package:flutter/material.dart';
import 'package:kman/featuers/benefits/screens/sports/sports_details_screen.dart';
import 'package:kman/featuers/benefits/widget/sports_details/custom_sports_slider.dart';

import '../../../../models/sports_model.dart';
import '../../../../theme/pallete.dart';
import '../../../play/widget/play/showrating.dart';

class CustomSportsBody extends StatelessWidget {
  final Size size;
  final SportsModel sportsModel;
  Alignment alignment;
  SportsFilterStatus status;
  CustomSportsBody(
      {super.key,
      required this.sportsModel,
      required this.size,
      required this.alignment,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Column(
      children: [
        Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Pallete.primaryColor),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.01),
              child: Center(
                child: CircleAvatar(
                    backgroundColor: Pallete.primaryColor,
                    radius: size.width * 0.2,
                    backgroundImage: NetworkImage(sportsModel.image)),
              ),
            )),
        SizedBox(
          height: size.width * 0.01,
        ),
        Text(
          "${sportsModel.name}",
          style: TextStyle(
              fontFamily: "Muller",
              color: Pallete.whiteColor,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: size.width * 0.008,
        ),
        Text(
          "Sports Shop",
          style: TextStyle(
            fontFamily: "Muller",
            color: Pallete.whiteColor,
            fontSize: size.width * 0.05,
          ),
        ),
        RatingDisplayWidget(
            rating: sportsModel.rating,
            color: Pallete.ratingColor,
            size: size.width * 0.06),
        // CustomSportsSlider(size: size, status: status, alignment: alignment),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.02),
          child: Container(
            height: size.height * 0.3,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(
                        fontFamily: "Muller",
                        color: Color.fromARGB(255, 250, 220, 52),
                        fontSize: size.width * 0.037,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${sportsModel!.about}",
                      style: TextStyle(
                        fontFamily: "Muller",
                        height: size.width * 0.0037,
                        color: Pallete.whiteColor,
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
