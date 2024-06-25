import 'package:flutter/material.dart';
import 'package:kman/featuers/orders/widget/my_reservision/custom_get_user_coaches_reservisions.dart';
import 'package:kman/featuers/orders/widget/my_reservision/custom_get_user_gym_reservisions.dart';
import 'package:kman/featuers/orders/widget/my_reservision/custom_get_user_medical_reservisions.dart';
import 'package:kman/featuers/orders/widget/my_reservision/custom_get_user_sports_reservisions.dart';
import '../../../HandlingDataView.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/common/custom_play_uppersec_logo.dart';
import '../../../core/providers/checkInternet.dart';
import '../../../theme/pallete.dart';
import '../widget/my_reservision/custom_get_user_nutition_reservisions.dart';

class MyReservisionsScreens extends StatefulWidget {
  const MyReservisionsScreens({super.key});

  @override
  State<MyReservisionsScreens> createState() => _MyReservisionsScreensState();
}

Alignment _alignment = Alignment.centerLeft;
MyReservisionFilterStatus status = MyReservisionFilterStatus.Coaches;

enum MyReservisionFilterStatus { Gyms, Coaches, Medical, Sports, Nutrition }

class _MyReservisionsScreensState extends State<MyReservisionsScreens> {
  StatusRequest statusRequest = StatusRequest.success;

  checkinternet() async {
    if (await checkInternet()) {
      setState(() {
        statusRequest = StatusRequest.success;
      });
    } else {
      setState(() {
        statusRequest = StatusRequest.offlinefalire2;
      });
    }
  }

  @override
  void initState() {
    checkinternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          CustomPlayUpperSecLogo(
            title: "My Reservisions",
            color: Pallete.fontColor,
            size: size,
            onLogoTap: () {},
          ),
          SizedBox(
            height: size.height * 0.013,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.13),
            child: const Divider(
              thickness: 2,
              color: Color.fromARGB(94, 146, 146, 146),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    status = MyReservisionFilterStatus.Coaches;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: status == MyReservisionFilterStatus.Coaches
                          ? const Border(
                              bottom: BorderSide(
                                  width: 2, color: Pallete.fontColor))
                          : null),
                  child: Text(
                    "Coaches",
                    style: TextStyle(
                        color: status == MyReservisionFilterStatus.Coaches
                            ? Pallete.fontColor
                            : const Color.fromARGB(255, 133, 133, 133),
                        fontFamily: "Inter",
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    status = MyReservisionFilterStatus.Gyms;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: status == MyReservisionFilterStatus.Gyms
                          ? const Border(
                              bottom: BorderSide(
                                  width: 2, color: Pallete.fontColor))
                          : null),
                  child: Text(
                    "Gyms",
                    style: TextStyle(
                        color: status == MyReservisionFilterStatus.Gyms
                            ? Pallete.fontColor
                            : const Color.fromARGB(255, 133, 133, 133),
                        fontFamily: "Inter",
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    status = MyReservisionFilterStatus.Medical;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: status == MyReservisionFilterStatus.Medical
                          ? const Border(
                              bottom: BorderSide(
                                  width: 2, color: Pallete.fontColor))
                          : null),
                  child: Text(
                    "Medical",
                    style: TextStyle(
                        color: status == MyReservisionFilterStatus.Medical
                            ? Pallete.fontColor
                            : const Color.fromARGB(255, 133, 133, 133),
                        fontFamily: "Inter",
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    status = MyReservisionFilterStatus.Sports;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: status == MyReservisionFilterStatus.Sports
                          ? const Border(
                              bottom: BorderSide(
                                  width: 2, color: Pallete.fontColor))
                          : null),
                  child: Text(
                    "Sports",
                    style: TextStyle(
                        color: status == MyReservisionFilterStatus.Sports
                            ? Pallete.fontColor
                            : const Color.fromARGB(255, 133, 133, 133),
                        fontFamily: "Inter",
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    status = MyReservisionFilterStatus.Nutrition;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: status == MyReservisionFilterStatus.Nutrition
                          ? const Border(
                              bottom: BorderSide(
                                  width: 2, color: Pallete.fontColor))
                          : null),
                  child: Text(
                    "Nutrition",
                    style: TextStyle(
                        color: status == MyReservisionFilterStatus.Nutrition
                            ? Pallete.fontColor
                            : const Color.fromARGB(255, 133, 133, 133),
                        fontFamily: "Inter",
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 0.01,
          ),
          HandlingDataView(
              statusRequest: statusRequest,
              widget: status == MyReservisionFilterStatus.Coaches
                  ? CustomGetUsercoachesReservisions()
                  : status == MyReservisionFilterStatus.Gyms
                      ? CustomGetUserGymReservisions()
                      : status == MyReservisionFilterStatus.Sports
                          ? CustomGetUserSportsReservisions()
                          : status == MyReservisionFilterStatus.Nutrition
                              ? CustomGetUserNutritionReservisions()
                              : CustomGetUserMedicalReservisions())
        ],
      ),
    ));
  }
}
