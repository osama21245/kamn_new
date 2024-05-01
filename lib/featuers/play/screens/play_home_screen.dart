import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/common/getcolor.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/play/delegates/search_basketground_delegate.dart';
import 'package:kman/featuers/play/delegates/search_footballground_delegate.dart';
import 'package:kman/featuers/play/delegates/search_volleyground_delegate.dart';
import 'package:kman/featuers/play/screens/add_ground_screen.dart';
import 'package:kman/featuers/play/widget/play_home/custom_get_joined_resevisions.dart';
import 'package:kman/theme/pallete.dart';
import '../../../core/common/custom_play_uppersec.dart';
import '../../../core/providers/checkInternet.dart';
import '../controller/play_controller.dart';
import '../delegates/search_paddelground_delegate.dart';
import '../widget/play/custom_get_grounds.dart';

class PlayHomeScreen extends ConsumerStatefulWidget {
  final String collection;
  const PlayHomeScreen({super.key, required this.collection});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayHomeScreenState();
}

Alignment _alignment = Alignment.centerLeft;
PlayFilterStatus status = PlayFilterStatus.Join;

enum PlayFilterStatus { Join, Grounds }

class _PlayHomeScreenState extends ConsumerState<PlayHomeScreen> {
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

  changeReadyToPlay(WidgetRef ref, BuildContext context) {
    ref.watch(playControllerProvider.notifier).changeReadyToPlay(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final color = getColor(widget.collection);
    final user = ref.read(usersProvider);
    List<Color> backGroundGridentColor = getGrediantColors(widget.collection);
    return Scaffold(
      floatingActionButton: user!.state == "1"
          ? FloatingActionButton(
              backgroundColor: color,
              onPressed: () => Get.to(() => AddGroundScreen(
                    collection: widget.collection,
                    fromAsk: false,
                  )),
              child: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomPlayUpperSec(
              title: widget.collection,
              color: color,
              size: size,
              onsearchTap: () => showSearch(
                  context: context,
                  delegate: widget.collection == "Football"
                      ? SearchFootballGroundDelegate(
                          ref,
                          widget.collection,
                          color,
                          backGroundGridentColor,
                          size,
                        )
                      : widget.collection == "Basketball"
                          ? SearchBasketBallGroundDelegate(
                              ref,
                              widget.collection,
                              color,
                              backGroundGridentColor,
                              size,
                            )
                          : widget.collection == "Padel"
                              ? SearchPaddelGroundDelegate(
                                  ref,
                                  widget.collection,
                                  color,
                                  backGroundGridentColor,
                                  size,
                                )
                              : SearchVolleyBallGroundDelegate(
                                  ref,
                                  widget.collection,
                                  color,
                                  backGroundGridentColor,
                                  size,
                                )),
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
                    value: user.isactive,
                    onChanged: (v) => changeReadyToPlay(ref, context),
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
                      status = PlayFilterStatus.Grounds;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: status == PlayFilterStatus.Grounds
                            ? Border(bottom: BorderSide(width: 2, color: color))
                            : null),
                    child: Text(
                      "Grounds",
                      style: TextStyle(
                          color: status == PlayFilterStatus.Grounds
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
                      status = PlayFilterStatus.Join;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: status == PlayFilterStatus.Join
                            ? Border(bottom: BorderSide(width: 2, color: color))
                            : null),
                    child: Text(
                      "JoinGrounds",
                      style: TextStyle(
                          color: status == PlayFilterStatus.Join
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
            SizedBox(
              height: size.width * 0.01,
            ),
            HandlingDataView(
                statusRequest: statusRequest,
                widget: status == PlayFilterStatus.Grounds
                    ? CustomGetGrounds(
                        backgroundColor: backGroundGridentColor,
                        size: size,
                        collection: widget.collection,
                        color: color,
                        status: status,
                      )
                    : CustomGetJoinedReservisions(
                        collection: widget.collection,
                        color: color,
                        backgroundColor: backGroundGridentColor,
                        size: size))
          ],
        ),
      ),
    );
  }
}

//starting files