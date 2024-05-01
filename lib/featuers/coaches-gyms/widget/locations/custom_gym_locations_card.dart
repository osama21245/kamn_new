import 'package:flutter/material.dart';
import 'package:kman/models/gym_locations_model.dart';
import '../../../../theme/pallete.dart';

class CustomGymLocationCard extends StatelessWidget {
  final GymLocationsModel gymLocationsModel;
  const CustomGymLocationCard({super.key, required this.gymLocationsModel});

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
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.1, top: size.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${gymLocationsModel.name}",
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: "Muller",
                                height: size.width * 0.0037,
                                color: Pallete.whiteColor,
                                fontSize: size.width * 0.063,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: size.width * 0.04,
                            ),
                            Text(
                              "${gymLocationsModel.address}",
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: "Muller",
                                color: const Color.fromARGB(146, 255, 255, 255),
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: size.width * 0.014,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 0.007),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.015,
                                        vertical: size.width * 0.005),
                                    decoration: BoxDecoration(
                                        color: Pallete.fontColor,
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.02)),
                                    child: Text(
                                      "${gymLocationsModel.ismix == true ? "Mix" : "Separate"}",
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontFamily: "Muller",
                                        color: Pallete.whiteColor,
                                        fontSize: size.width * 0.027,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
