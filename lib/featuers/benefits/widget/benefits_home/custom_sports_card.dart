// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/play/widget/play/showrating.dart';
import 'package:kman/models/nutrition_model.dart';
import 'package:kman/models/sports_model.dart';
import 'package:kman/theme/pallete.dart';

class CustomSportsCard extends ConsumerWidget {
  SportsModel sportsModel;
  CustomSportsCard({
    required this.sportsModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          bottom: size.width * 0.013),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(size.width * 0.02),
        child: Stack(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.17,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: Pallete.listofGridientCard,
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width * 0.018),
                              bottomLeft: Radius.circular(size.width * 0.018))),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.016),
                            child: Container(
                              width: size.width * 0.28,
                              height: size.width * 0.3,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.01),
                                child: Image.network(
                                  sportsModel.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${sportsModel.name}",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: "Muller",
                                    height: size.width * 0.0037,
                                    color: Pallete.whiteColor,
                                    fontSize: size.width * 0.053,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Sports Shop",
                                  style: TextStyle(
                                    fontFamily: "Muller",
                                    color: Pallete.whiteColor,
                                    fontSize: size.width * 0.034,
                                    height: size.width * 0.0027,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                RatingDisplayWidget(
                                    rating: sportsModel.rating,
                                    color:
                                        const Color.fromARGB(255, 255, 241, 42),
                                    size: size.width * 0.05),
                                Text(
                                  "${sportsModel.discount} %",
                                  maxLines: 3,
                                  style: TextStyle(
                                    wordSpacing: -0.4,
                                    fontFamily: "Muller",
                                    height: size.width * 0.0037,
                                    color: Pallete.whiteColor,
                                    fontSize: size.width * 0.07,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Free Delivery",
                                  maxLines: 3,
                                  style: TextStyle(
                                    wordSpacing: -0.4,
                                    fontFamily: "Muller",
                                    color: Pallete.whiteColor,
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(size.width * 0.018),
                            bottomRight: Radius.circular(size.width * 0.018)),
                        color: Pallete.fontColor),
                    height: size.height * 0.17,
                    width: size.width * 0.1,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Center(
                        child: Text(
                          "Details",
                          style: TextStyle(
                              fontFamily: "Muller",
                              color: Pallete.whiteColor,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: size.width * 0.09,
                top: size.width * 0.2,
                child: Image.asset(
                  "assets/page-1/images/kamn_sentence_white.png",
                  width: size.width * 0.15,
                )),
          ],
        ),
      ),
    );
  }
}
