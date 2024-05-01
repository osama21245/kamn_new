import 'package:flutter/material.dart';
import '../../../../../theme/pallete.dart';
import '../../../play/widget/play/showrating.dart';

class CustomServiceProviderCard extends StatelessWidget {
  String name;
  int price;
  String address;
  double rating;
  CustomServiceProviderCard({
    Key? key,
    required this.name,
    required this.price,
    required this.address,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(size.width * 0.02),
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: size.height * 0.17,
                  decoration: BoxDecoration(
                      color: Pallete.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size.width * 0.018),
                          bottomLeft: Radius.circular(size.width * 0.018))),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.026),
                        child: Image.asset(
                          "assets/page-1/images/golds.png",
                          width: size.width * 0.2,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "$name",
                            maxLines: 3,
                            style: TextStyle(
                              fontFamily: "Muller",
                              height: size.width * 0.0037,
                              color: Pallete.whiteColor,
                              fontSize: size.width * 0.053,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RatingDisplayWidget(
                              rating: rating,
                              color: const Color.fromARGB(255, 255, 241, 42),
                              size: size.width * 0.05),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 0.01),
                            child: Image.asset(
                              "assets/page-1/images/whiteLocation.png",
                              width: size.width * 0.03,
                            ),
                          ),
                          Text(
                            "${address}",
                            maxLines: 3,
                            style: TextStyle(
                              fontFamily: "Muller",
                              color: Pallete.whiteColor,
                              fontSize: size.width * 0.034,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${price} EGP / Month",
                            maxLines: 3,
                            style: TextStyle(
                              wordSpacing: -0.4,
                              fontFamily: "Muller",
                              height: size.width * 0.0037,
                              color: Pallete.whiteColor,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
