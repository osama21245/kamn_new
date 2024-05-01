// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:kman/models/grounds_model.dart';
import 'package:kman/models/reserved_model.dart';
import 'package:kman/theme/pallete.dart';

import '../../../play/widget/play/showrating.dart';

class CustomGroundReservisionCard extends StatelessWidget {
  final ReserveModel reserveModel;
  final Color color;

  const CustomGroundReservisionCard(
      {Key? key, required this.color, required this.reserveModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.width * 0.02),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.035, vertical: size.width * 0.012),
        child: Stack(
          children: [
            Opacity(
              opacity: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    15 * fem, 78 * fem, 15 * fem, 104 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                    color: color),
              ),
            ),
            Positioned.fill(
                child: Opacity(
              opacity: 0.85,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.02),
                child: CachedNetworkImage(
                  imageUrl: reserveModel.groundImage,
                  fit: BoxFit.cover,
                  width: size.width,
                ),
              ),
            )),
            Positioned(
              top: 15 * fem,
              left: 9 * fem,
              right: 15 * fem,
              child: Column(
                children: [
                  Text(
                    '${reserveModel.category}',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  RatingDisplayWidget(
                    size: size.width * 0.06,
                    color: Color.fromARGB(255, 251, 255, 42),
                    rating: 4.5,
                  ),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/page-1/images/whiteLocation.png",
                        width: size.width * 0.04,
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        "${reserveModel.day}",
                        style: TextStyle(
                          color: Pallete.whiteColor,
                          fontSize: size.width * 0.04,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${reserveModel.time} EGP/Hr",
                          style: TextStyle(
                              fontFamily: "Muller",
                              color: Pallete.whiteColor,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
