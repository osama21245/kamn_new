import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/common/custom_uppersec.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/delegates/search_medical_delegate.dart';
import 'package:kman/featuers/benefits/delegates/search_nutirition_delegate%20.dart';
import 'package:kman/featuers/benefits/screens/medical/add_medical_screen.dart';
import 'package:kman/featuers/benefits/screens/nutrition/add_nutrition_screen.dart';
import 'package:kman/featuers/benefits/screens/sports/add_sports_screen.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_get_medical.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_get_nutrition.dart';
import 'package:kman/theme/pallete.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/providers/checkInternet.dart';
import '../../play/widget/play/custom_play_serarch.dart';

class BenefitsHomeScreen extends ConsumerStatefulWidget {
  const BenefitsHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BenefitsHomeScreenState();
}

Alignment _alignment = Alignment.centerLeft;
BenefitsFilterStatus status = BenefitsFilterStatus.Medical;

enum BenefitsFilterStatus { Medical, Nutrition }

class _BenefitsHomeScreenState extends ConsumerState<BenefitsHomeScreen> {
  StatusRequest statusRequest = StatusRequest.success;
  String region = "All";

  checkinternet() async {
    setState(() {
      statusRequest = StatusRequest.loading2;
    });

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
    final user = ref.read(usersProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: user!.state == "1"
          ? FloatingActionButton(
              onPressed: () {
                if (status == BenefitsFilterStatus.Medical) {
                  Get.to(() => const AddMedicalScreen(
                        fromAsk: false,
                      ));
                } else if (status == BenefitsFilterStatus.Nutrition) {
                  Get.to(() => const AddNutrtionScreen(
                        fromAsk: false,
                      ));
                } else {
                  Get.to(() => const AddSportsScreen(
                        fromAsk: false,
                      ));
                }
              },
              child: Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            CustomUpperSec(
              size: size,
              color: Pallete.fontColor,
              title: "${status.name}",
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
              thickness: 3,
              color: Colors.black,
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.02,
                      top: size.width * 0.01,
                      right: size.width * 0.02),
                  child: Row(
                    children: [
                      for (BenefitsFilterStatus filterStatus
                          in BenefitsFilterStatus.values)
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (filterStatus ==
                                    BenefitsFilterStatus.Medical) {
                                  status = BenefitsFilterStatus.Medical;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    BenefitsFilterStatus.Nutrition) {
                                  status = BenefitsFilterStatus.Nutrition;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: Container(
                                  width: size.width * 0.47,
                                  height: size.height * 0.046,
                                  decoration: BoxDecoration(
                                    color: Pallete.greyColor,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.014),
                                  ),
                                  child: Center(
                                    child: Text(
                                      filterStatus.name,
                                      style: TextStyle(
                                          color: Pallete.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.02),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.02,
                        top: size.width * 0.01,
                        right: size.width * 0.02),
                    child: Container(
                      width: size.width * 0.48,
                      height: size.height * 0.046,
                      decoration: BoxDecoration(
                        color: Pallete.primaryColor,
                        borderRadius: BorderRadius.circular(size.width * 0.014),
                      ),
                      child: Center(
                        child: Text(
                          status.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () => showSearch(
                  context: context,
                  delegate: status == BenefitsFilterStatus.Medical
                      ? SearchMedicalDelegate(ref, "medical", size)
                      : SearchNutiritionDelegate(ref, "nutrition", size)),
              child: CustomPlaySearch(
                size: size,
                category: status.name,
              ),
            ),
            // SizedBox(
            //   height: size.height * 0.01,
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Pallete.fontColor),
            //     borderRadius: BorderRadius.circular(size.width * 0.02),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            //     child: DropdownButton(
            //       underline: Text(""),
            //       style: TextStyle(
            //         color: Pallete.lightgreyColor2,
            //         fontFamily: "Muller",
            //         fontSize: size.width * 0.037,
            //         fontWeight: FontWeight.w500,
            //       ),
            //       isExpanded: true,
            //       value: region,
            //       focusColor: const Color.fromARGB(0, 255, 192, 192),
            //       items: alexandriaRegions.map((region) {
            //         return DropdownMenuItem(
            //           value: region,
            //           child: Text(region),
            //         );
            //       }).toList(),
            //       onChanged: (value) {
            //         setState(() {
            //           region = value!;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.01,
            ),
            HandlingDataView(
                statusRequest: statusRequest,
                widget: status == BenefitsFilterStatus.Medical
                    ? CustomGetMedical(
                        region: "All",
                        fromOrders: false,
                      )
                    : CustomGetNutrition(
                        region: "All",
                        fromOrders: false,
                      ))
          ],
        ),
      ),
    );
  }
}
