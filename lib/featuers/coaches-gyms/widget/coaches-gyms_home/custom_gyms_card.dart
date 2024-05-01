import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kman/models/gym_model.dart';
import '../../../../theme/pallete.dart';

class CustomGymCard extends StatelessWidget {
  final GymModel gymModel;
  const CustomGymCard({super.key, required this.gymModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          bottom: size.width * 0.015),
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
                                horizontal: size.width * 0.026),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02),
                              child: CachedNetworkImage(
                                imageUrl: gymModel.image,
                                width: size.width * 0.23,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${gymModel.name}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: "Muller",
                                    height: size.width * 0.0037,
                                    color: Pallete.whiteColor,
                                    fontSize: size.width * 0.053,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  "Enjoy our offers at ${gymModel.name} without limits, exclusive and distinctive offers only here at Kamn",
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontFamily: "Muller",
                                    color: const Color.fromARGB(
                                        122, 255, 255, 255),
                                    fontSize: size.width * 0.034,
                                    fontWeight: FontWeight.w400,
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
