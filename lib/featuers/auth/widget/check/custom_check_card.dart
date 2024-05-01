// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../screens/check_screen.dart';

class CustomCheckCard extends StatelessWidget {
  String image;
  CheckFilterStatus status;
  String section;
  Size size;
  CustomCheckCard(
      {Key? key,
      required this.image,
      required this.status,
      required this.section,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.width * 0.02),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
        child: Stack(
          children: [
            Container(
              padding:
                  EdgeInsets.fromLTRB(15 * fem, 120 * fem, 15 * fem, 70 * fem),
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
                  color: status == CheckFilterStatus.Collaborator &&
                              section == "COLLABORATOR" ||
                          status == CheckFilterStatus.Player &&
                              section != "COLLABORATOR"
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
              child: status == CheckFilterStatus.Collaborator &&
                          section == "COLLABORATOR" ||
                      status == CheckFilterStatus.Player &&
                          section != "COLLABORATOR"
                  ? AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        ColorizeAnimatedText("$section",
                            speed: Duration(milliseconds: 500),
                            textStyle: TextStyle(
                                fontFamily: "Muller",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: size.width * 0.09),
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
            if (section == "Store" ||
                section == "Tournaments" ||
                section == "Leaderboard")
              Positioned(
                  child: Image.asset(
                "assets/page-1/images/kamn_sentence_white.png",
                width: size.width * 0.09,
              ))
          ],
        ),
      ),
    );
  }
}
