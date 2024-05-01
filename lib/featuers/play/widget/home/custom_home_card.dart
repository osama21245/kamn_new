// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/benefits/screens/benefits_home_screen.dart';
import 'package:kman/featuers/coaches-gyms/screens/coaches-gyms_home_screen.dart';
import '../../../benefits/screens/sports/sports_home_screen.dart';
import '../../screens/categories_screen.dart';

class CustomHomeCard extends StatelessWidget {
  final String image;
  final String section;
  final Size size;
  const CustomHomeCard(
      {Key? key,
      required this.image,
      required this.section,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return InkWell(
      onTap: () {
        if (section == "Play") {
          Get.to(() => CategoriesScreen());
        } else if (section == "Coaches - Gym") {
          Get.to(() => CoachesGymsHomeScreen());
        } else if (section == "Benefits") {
          Get.to(() => BenefitsHomeScreen());
        } else if (section == "Store") {
          Get.to(() => SportsHomeScreen());
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.02),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
          child: Stack(
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(15 * fem, 78 * fem, 15 * fem, 70 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('$image'),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: section == "Tournaments" || section == "Leaderboard"
                        ? Colors.black.withOpacity(0.87)
                        : Colors.black
                            .withOpacity(0.2), // Adjust opacity as needed
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                  ),
                ),
              ),
              Positioned(
                bottom: 35 * fem,
                left: 15 * fem,
                right: 15 * fem,
                child: section == "Tournaments" || section == "Leaderboard"
                    ? AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          ColorizeAnimatedText("SOON IN KAMN",
                              speed: Duration(milliseconds: 500),
                              textStyle: TextStyle(
                                  fontFamily: "Muller",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: size.width * 0.07),
                              colors: [
                                const Color.fromARGB(132, 255, 255, 255),
                                const Color.fromARGB(151, 155, 39, 176),
                                const Color.fromARGB(134, 33, 149, 243),
                                const Color.fromARGB(157, 255, 235, 59)
                              ]),
                        ],
                      )
                    : Text(
                        '$section',
                        style: TextStyle(
                            color: Color(0xfffafafa),
                            fontFamily: "Muller",
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.w600),
                      ),
              ),
              if (section == "Tournaments" || section == "Leaderboard")
                Positioned(
                    child: Image.asset(
                  "assets/page-1/images/kamn_sentence_white.png",
                  width: size.width * 0.09,
                ))
            ],
          ),
        ),
      ),
    );
  }
}
