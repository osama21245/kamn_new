import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/common/custom_elevated_button.dart';
import 'package:kman/core/common/custom_uppersec.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:kman/featuers/play/widget/reservision_details/custom_ground_section.dart';
import 'package:kman/models/reserved_model.dart';
import 'package:lottie/lottie.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/textfield.dart';
import '../../../core/constants/imgaeasset.dart';
import '../../../core/providers/valid.dart';
import '../../../theme/pallete.dart';
import '../../../core/function/check_date.dart';

class ReservisionDetailsScreen extends ConsumerStatefulWidget {
  final ReserveModel reserveModel;
  final bool fromJoinOrLeave;
  const ReservisionDetailsScreen(
      {super.key, required this.reserveModel, required this.fromJoinOrLeave});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservisionDetailsScreenState();
}

class _ReservisionDetailsScreenState
    extends ConsumerState<ReservisionDetailsScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool askForrPlayers = false;
  TextEditingController? numberOfNeededPlayers;
  String numberOfNeededPlayersForPage = "";

  @override
  void initState() {
    numberOfNeededPlayers = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    numberOfNeededPlayers!.dispose();
    super.dispose();
  }

  void askForPlayers() {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      ref.watch(playControllerProvider.notifier).askForPlayers(
          widget.reserveModel.id,
          int.parse(numberOfNeededPlayers!.text),
          context);
      askForrPlayers = true;
      // numberOfNeededPlayers!.clear();
      numberOfNeededPlayersForPage = numberOfNeededPlayers!.text;
      setState(() {});
    }
  }

  void deleteYourReservision() {
    ref
        .watch(playControllerProvider.notifier)
        .cancelReservision(widget.reserveModel.id, context);
    Get.back();
  }

  void joinGame(
      WidgetRef ref, BuildContext context, int points, String userId) {
    ref
        .watch(playControllerProvider.notifier)
        .joinGame(widget.reserveModel.id, context, points);
    widget.reserveModel.collaborations.add(userId);
    setState(() {});
  }

  void latJoinGame(
      WidgetRef ref, BuildContext context, int points, String userId) {
    ref.watch(playControllerProvider.notifier).lastjoinGame(
        widget.reserveModel.id,
        context,
        points,
        widget.reserveModel.reservisionMakerId);
    widget.reserveModel.collaborations.add(userId);
    setState(() {});
  }

  void leaveGame(
      WidgetRef ref, BuildContext context, int points, String userId) {
    ref
        .watch(playControllerProvider.notifier)
        .leaveGame(widget.reserveModel.id, context, points);
    widget.reserveModel.collaborations.remove(userId);
    setState(() {});
  }

  List<String> cityList = [
    'Cairo',
    'Alex',
  ];

  @override
  Widget build(BuildContext context) {
    Tuple2 tuple =
        Tuple2(widget.reserveModel.category, widget.reserveModel.groundId);
    Size size = MediaQuery.of(context).size;
    final user = ref.read(usersProvider);
    final dateParts = widget.reserveModel.day.split('/');
    final year = int.parse(dateParts[2]);
    final month = int.parse(dateParts[0]);
    final day = int.parse(dateParts[1]);
    final date = DateTime(year, month, day);

    return Scaffold(
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: CustomElevatedButton(
            color: const Color.fromARGB(255, 239, 83, 80),
            size: size,
            title:
                '${widget.fromJoinOrLeave && widget.reserveModel.collaborations.contains(user!.uid) ? "Leave" : widget.fromJoinOrLeave && !widget.reserveModel.collaborations.contains(user!.uid) ? "Join" : "Delete Your Reservision"}',
            sizeofwidth: size.width,
            sizeofhight: size.height * 0.04,
            onTap: () => widget.fromJoinOrLeave &&
                    widget.reserveModel.collaborations.contains(user!.uid)
                ? leaveGame(ref, context, user!.points - 20, user.uid)
                : widget.fromJoinOrLeave &&
                        !widget.reserveModel.collaborations.contains(user!.uid)
                    ? widget.reserveModel.collaborations.length + 1 >=
                            widget.reserveModel.targetplayesNum
                        ? latJoinGame(ref, context, user!.points + 20, user.uid)
                        : joinGame(ref, context, user!.points + 20, user.uid)
                    : isDateTwoDaysApart(
                        date, deleteYourReservision, size, context),
          )),
      body: SafeArea(
        child: Form(
          key: formstate,
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CustomUpperSec(
                      size: size,
                      color: Pallete.fontColor,
                      title: "Reservision Details")),
              SizedBox(
                height: size.height * 0.027,
              ),
              Container(
                height: size.height * 0.73,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 17.0, top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Reservision Time : ",
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Pallete.primaryColor)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: ListTile(
                                      title: Text(
                                          "Day :${widget.reserveModel.day}"),
                                      subtitle: Text(
                                          "Time :${widget.reserveModel.time}"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.0),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    if (!widget.fromJoinOrLeave)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 17.0, top: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Ask for players : ",
                                              style: TextStyle(
                                                  fontSize: size.width * 0.05,
                                                  color: Pallete.primaryColor)),
                                          SizedBox(
                                            width: size.width * 0.13,
                                          ),
                                          if (widget.reserveModel.iscomplete ==
                                                  false ||
                                              askForrPlayers == true)
                                            Text(
                                                "Collaborations  ${widget.reserveModel.collaborations.length}/${numberOfNeededPlayersForPage != "" ? numberOfNeededPlayersForPage : widget.reserveModel.targetplayesNum}",
                                                style: TextStyle(
                                                    fontSize: size.width * 0.03,
                                                    color: Pallete.redColor)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(size.width * 0.04),
                                      child: TextFiled(
                                        keytypeisnumber: true,
                                        validator: (val) {
                                          return validinput(val!, 1, 500, "");
                                        },
                                        name: "Number of needed players",
                                        controller: numberOfNeededPlayers!,
                                        color: Pallete.lightgreyColor2,
                                      ),
                                    ),
                                    CustomElevatedButton(
                                      color: Pallete.primaryColor,
                                      size: size,
                                      title: "Ask",
                                      sizeofwidth: size.width * 0.3,
                                      sizeofhight: size.height * 0.04,
                                      onTap: () => askForPlayers(),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ref.watch(getGroundDataProvider(tuple)).when(
                        data: (groundModel) =>
                            CustomGroundSection(groundModel: groundModel),
                        error: (error, StackTrace) {
                          print(error);

                          return ErrorText(error: error.toString());
                        },
                        loading: () => LottieBuilder.asset(
                              fit: BoxFit.contain,
                              AppImageAsset.loading,
                              repeat: true,
                            ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
