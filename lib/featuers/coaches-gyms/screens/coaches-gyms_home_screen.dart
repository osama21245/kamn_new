import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/common/custom_uppersec.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/coaches-gyms/delegates/search_coach_delegate.dart';
import 'package:kman/featuers/coaches-gyms/delegates/search_gyms_delegate%20.dart';
import 'package:kman/featuers/coaches-gyms/screens/coach/add_coach_screen.dart';
import 'package:kman/featuers/coaches-gyms/widget/coaches-gyms_home/custom_get_coaches.dart';
import 'package:kman/featuers/coaches-gyms/widget/coaches-gyms_home/custom_get_gyms.dart';
import 'package:kman/theme/pallete.dart';
import '../../../core/class/alex_regions_lists.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/providers/checkInternet.dart';
import '../../play/widget/play/custom_play_serarch.dart';
import 'gym/add_gym_screen.dart';

class CoachesGymsHomeScreen extends ConsumerStatefulWidget {
  const CoachesGymsHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CoachesGymsHomeScreenState();
}

Alignment _alignment = Alignment.centerLeft;
CoachesGymsFilterStatus status = CoachesGymsFilterStatus.Coaches;

enum CoachesGymsFilterStatus { Coaches, Gyms }

class _CoachesGymsHomeScreenState extends ConsumerState<CoachesGymsHomeScreen> {
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
                if (status == CoachesGymsFilterStatus.Coaches) {
                  Get.to(() => const AddCoachScreen(
                        fromAsk: false,
                      ));
                } else {
                  Get.to(() => const AddgymScreen(
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
                  padding: EdgeInsets.only(left: size.width * 0.02),
                  child: Row(
                    children: [
                      for (CoachesGymsFilterStatus filterStatus
                          in CoachesGymsFilterStatus.values)
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                print(user!.state);
                                if (filterStatus ==
                                    CoachesGymsFilterStatus.Coaches) {
                                  status = CoachesGymsFilterStatus.Coaches;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    CoachesGymsFilterStatus.Gyms) {
                                  status = CoachesGymsFilterStatus.Gyms;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: Container(
                                  width: size.width * 0.47,
                                  height: size.height * 0.054,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Container(
                      width: size.width * 0.48,
                      height: size.height * 0.054,
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
            CustomPlaySearch(
              isshowFilter:
                  status == CoachesGymsFilterStatus.Coaches ? false : true,
              onSearchPress: () => showSearch(
                  context: context,
                  delegate: status == CoachesGymsFilterStatus.Coaches
                      ? SearchCoachDelegate(ref, "coach", size)
                      : SearchGymDelegate(ref, "gym", size)),
              onfilterPress: () {
                showMenu<String>(
                  color: Colors.blue[300],
                  context: context,
                  position: RelativeRect.fromLTRB(15, 20, 30, 60),
                  items: alexandriaRegions.map((region) {
                    return PopupMenuItem(
                      value: region,
                      child: Text(region),
                    );
                  }).toList(),
                ).then((selectedValue) {
                  if (selectedValue != null) {
                    setState(() {
                      region = selectedValue;
                    });
                  }
                });
              },
              size: size,
              category: status.name,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            HandlingDataView(
                statusRequest: statusRequest,
                widget: status == CoachesGymsFilterStatus.Coaches
                    ? CustomGetCoaches(
                        fromOrders: false,
                      )
                    : CustomGetGyms(
                        fromOrders: false,
                      ))
          ],
        ),
      ),
    );
  }
}
