import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/user/widget/my%20Play/custom_get_user_joined_resevisions.dart';
import 'package:kman/featuers/user/widget/my%20Play/custom_get_resevisions.dart';
import 'package:kman/theme/pallete.dart';
import '../../../HandlingDataView.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/common/custom_play_uppersec.dart';
import '../../../core/common/custom_play_uppersec_logo.dart';
import '../../../core/providers/checkInternet.dart';
import '../../auth/controller/auth_controller.dart';

class MyPlayScreen extends ConsumerStatefulWidget {
  const MyPlayScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyReservisionsScreenState();
}

Alignment _alignment = Alignment.centerLeft;
MyReservisionFilterStatus status = MyReservisionFilterStatus.JoinGrounds;

enum MyReservisionFilterStatus { JoinGrounds, Grounds }

class _MyReservisionsScreenState extends ConsumerState<MyPlayScreen> {
  StatusRequest statusRequest = StatusRequest.success;

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
    Size size = MediaQuery.of(context).size;
    final color = Color.fromARGB(255, 10, 107, 185);
    final user = ref.read(usersProvider);
    List<Color> backGroundGridentColor = Pallete.primaryGridentColors;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomPlayUpperSecLogo(
              title: "My Play",
              color: color,
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
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.022,
                  bottom: size.width * 0.01,
                  right: size.width * 0.015),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Pallete.whiteColor,
                    activeColor: color,
                    value: true,
                    onChanged: (v) {},
                  ),
                  Text(
                    "i'm Free to play any time,any where",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 133, 133, 133),
                        fontFamily: "Inter",
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      status = MyReservisionFilterStatus.Grounds;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: status == MyReservisionFilterStatus.Grounds
                            ? Border(bottom: BorderSide(width: 2, color: color))
                            : null),
                    child: Text(
                      "Grounds",
                      style: TextStyle(
                          color: status == MyReservisionFilterStatus.Grounds
                              ? color
                              : const Color.fromARGB(255, 133, 133, 133),
                          fontFamily: "Inter",
                          fontSize: size.width * 0.049,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      status = MyReservisionFilterStatus.JoinGrounds;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: status == MyReservisionFilterStatus.JoinGrounds
                            ? Border(bottom: BorderSide(width: 2, color: color))
                            : null),
                    child: Text(
                      "JoinGrounds",
                      style: TextStyle(
                          color: status == MyReservisionFilterStatus.JoinGrounds
                              ? color
                              : const Color.fromARGB(255, 133, 133, 133),
                          fontFamily: "Inter",
                          fontSize: size.width * 0.049,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.width * 0.01,
            ),
            HandlingDataView(
                statusRequest: statusRequest,
                widget: status == MyReservisionFilterStatus.Grounds
                    ? CustomGetReservisions(
                        backgroundColor: backGroundGridentColor,
                        size: size,
                        color: color,
                        status: status,
                      )
                    : CustomGetUserJoinedReservisions(
                        backgroundColor: backGroundGridentColor,
                        size: size,
                        color: color,
                        status: status,
                      ))
          ],
        ),
      ),
    );
  }
}
