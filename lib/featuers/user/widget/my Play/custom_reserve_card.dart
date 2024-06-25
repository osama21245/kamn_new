// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/theme/pallete.dart';
import '../../../../models/reserved_model.dart';

class CustomReserveCard extends ConsumerWidget {
  final ReserveModel reserveModel;
  final Color color;

  const CustomReserveCard(
      {Key? key, required this.color, required this.reserveModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final user = ref.read(usersProvider);
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.width * 0.02),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.035, vertical: size.width * 0.012),
        child: Stack(
          children: [
            Container(
              padding:
                  EdgeInsets.fromLTRB(15 * fem, 125 * fem, 15 * fem, 104 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                  color: const Color.fromARGB(15, 83, 83, 83)),
            ),
            Positioned.fill(
                child: Opacity(
              opacity: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.05),
                child: Image.asset(
                  reserveModel.category == "Football"
                      ? "assets/page-1/images/football.jpg"
                      : reserveModel.category == "Basketball"
                          ? "assets/page-1/images/basketball.jpg"
                          : reserveModel.category == "Volleyball"
                              ? "assets/page-1/images/volleyball.jpg"
                              : reserveModel.category == "Tennis"
                                  ? "assets/page-1/images/tennis.jpg"
                                  : reserveModel.category == "Swiming"
                                      ? "assets/page-1/images/swimming2.jpg"
                                      : "assets/page-1/images/football.jpg",
                  fit: BoxFit.cover,
                  width: size.width,
                ),
              ),
            )),
            Positioned(
              top: 23 * fem,
              left: 7 * fem,
              right: 15 * fem,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.043),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          reserveModel.category,
                          style: TextStyle(
                              color: color,
                              fontFamily: "Inter",
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.003),
                        child: Row(
                          children: [
                            Text(
                              "Your Reservation",
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontFamily: "Inter",
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Day",
                                        style: TextStyle(
                                            color: Pallete.whiteColor,
                                            fontFamily: "Inter",
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.w600)),
                                    Text("     ${reserveModel.day}",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                157, 255, 255, 255),
                                            fontFamily: "Inter",
                                            fontSize: size.width * 0.035,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Time",
                                        style: TextStyle(
                                            color: Pallete.whiteColor,
                                            fontFamily: "Inter",
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.w600)),
                                    Text("  ${reserveModel.time}",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                157, 255, 255, 255),
                                            fontFamily: "Inter",
                                            fontSize: size.width * 0.035,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(size.width * 0.03),
                              decoration: BoxDecoration(
                                  border: Border.all(color: color),
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.07)),
                              child: Text(
                                reserveModel.collaborations.contains(user!.uid)
                                    ? "Leave"
                                    : !reserveModel.collaborations
                                            .contains(user!.uid)
                                        ? "Join"
                                        : "Details",
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        193, 255, 255, 255),
                                    fontFamily: "Inter",
                                    fontSize: size.width * 0.03,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
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
