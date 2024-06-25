import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/common/custom_uppersec.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/delegates/search_sports_delegate%20.dart';
import 'package:kman/featuers/benefits/screens/sports/add_sports_screen.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_get_sports.dart';
import 'package:kman/theme/pallete.dart';
import '../../../../core/class/alex_regions_lists.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/providers/checkInternet.dart';
import '../../../play/widget/play/custom_play_serarch.dart';

class SportsHomeScreen extends ConsumerStatefulWidget {
  const SportsHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SportsHomeScreenState();
}

class _SportsHomeScreenState extends ConsumerState<SportsHomeScreen> {
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
                Get.to(() => AddSportsScreen(
                      fromAsk: false,
                    ));
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
              title: "Sports Stores",
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
              thickness: 3,
              color: Colors.black,
            ),
            CustomPlaySearch(
              onSearchPress: () => showSearch(
                  context: context, delegate: SearchSportsDelegate(ref, size)),
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
              category: "Sports stores",
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            HandlingDataView(
                statusRequest: statusRequest,
                widget: CustomGetSports(region: region))
          ],
        ),
      ),
    );
  }
}
