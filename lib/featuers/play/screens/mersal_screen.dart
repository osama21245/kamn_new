import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/theme/pallete.dart';

import '../../../core/common/custom_uppersec.dart';

import '../../coaches-gyms/controller/coaches-gyms_controller.dart';
import '../../coaches-gyms/screens/coach/coaches_details_screen.dart';
import '../widget/play/showrating.dart';

class MersalScreen extends ConsumerWidget {
  const MersalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    openLink(String link) {
      ref.watch(coachesGymsControllerProvider.notifier).openLink(link, context);
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
      body: SafeArea(
        child: ListView(
          children: [
            CustomUpperSec(
              color: const Color.fromARGB(255, 190, 40, 13),
              size: size!,
              title: "Mersal",
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
              thickness: 3,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.22,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Pallete.whiteColor, width: 2))),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        child: Text(
                          "Air Sports",
                          style: TextStyle(
                            color: Pallete.whiteColor,
                            fontFamily: "Muller",
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.22,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Pallete.whiteColor, width: 2))),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                    ],
                  ),
                  RatingDisplayWidget(
                    size: size.width * 0.06,
                    color: Pallete.ratingColor,
                    rating: 4.5,
                  ),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.043),
              child: Column(
                children: [
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(size.width * 0.02),
                        child: Image.asset("assets/page-1/images/mersal.jpg")),
                  ),
                  SizedBox(
                    height: size.width * 0.043,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.005),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              fontFamily: "Muller",
                              color: Color.fromARGB(255, 190, 40, 13),
                              fontSize: size.width * 0.043,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.02,
                  ),
                  Text(
                    "لو انت بتحب الطيران و الجو يبقى انت في المكان الصح!!احنا هنا بتوع القفز بالمظلات و الsky diving و كل حاجة ليها علاقة بالطيران و الرياضات الجوية, تعالى كلمنا على الواتساب أو على منصات التواصل الإجتماعى و ليك خصم خاص لو أنت جى من تطبيق كامن!",
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: size.width * 0.038,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              openWhatsApp(ref, "01112458765", context),
                          child: Text("WhatsApp",
                              style: TextStyle(color: Pallete.whiteColor)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 190, 40, 13),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      size.width * 0.02))),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => openLink(
                              "https://www.facebook.com/mersalairsports?mibextid=LQQJ4d"),
                          child: Text(
                            "Vist our page",
                            style: TextStyle(color: Pallete.blackColor),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Pallete.whiteColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      size.width * 0.02))),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
