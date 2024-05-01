// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/auth/widget/check/custom_check_card.dart';

import '../controller/auth_controller.dart';

class CheckScreen extends ConsumerStatefulWidget {
  final String region;
  final String age;
  final String gender;
  const CheckScreen({
    required this.region,
    required this.age,
    required this.gender,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckScreenState();
}

enum CheckFilterStatus { Collaborator, Player }

Alignment _alignment = Alignment.centerLeft;

CheckFilterStatus status = CheckFilterStatus.Player;
StatusRequest statusRequest = StatusRequest.success;

class _CheckScreenState extends ConsumerState<CheckScreen> {
  signInWithGoogle(WidgetRef ref, BuildContext context, String status) {
    ref.watch(authControllerProvider.notifier).signinWithGoogle(
        context, true, status, widget.region, widget.age, widget.gender);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    statusRequest = ref.watch(authControllerProvider);
    return Scaffold(
        body: HandlingDataView(
      statusRequest: statusRequest,
      widget: Stack(
        children: [
          Container(
            height: size.height,
            child: Image.asset(
              "assets/page-1/images/Background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.width * 0.065),
                child: Image.asset("assets/page-1/images/loading_bar.png"),
              ),
              Container(
                width: size.width * 0.95,
                height: size.height * 0.123,
                child: Center(
                  child: Text(
                    'WHICH ONE ARE\nYOU?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xfffafafa),
                        fontFamily: "Muller",
                        fontSize: size.width * 0.06,
                        height: size.width * 0.004,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.03),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(195, 213, 41, 247),
                      Color.fromARGB(207, 41, 25, 184),
                    ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
              ),
              SizedBox(
                height: size.width * 0.04,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      status = CheckFilterStatus.Collaborator;
                    });
                  },
                  child: CustomCheckCard(
                      image: "assets/page-1/images/collaborators.png",
                      status: status,
                      section: "COLLABORATOR",
                      size: size)),
              SizedBox(
                height: size.width * 0.055,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      print(status);
                      status = CheckFilterStatus.Player;
                    });
                  },
                  child: CustomCheckCard(
                      image: "assets/page-1/images/sports_player.png",
                      status: status,
                      section: "SPORTS PLAYER",
                      size: size)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04, vertical: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'N.B:COLLABORATOR IS FOR SERVICE PROVIDERS',
                      style: TextStyle(
                          color: Color.fromARGB(255, 155, 14, 168),
                          fontFamily: "Muller",
                          fontSize: size.width * 0.036,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 0.04,
              ),
              InkWell(
                  onTap: () => signInWithGoogle(ref, context,
                      status == CheckFilterStatus.Collaborator ? "2" : "0"),
                  child: Image.asset(
                    "assets/page-1/images/next_button.png",
                    width: size.width * 0.85,
                  ))
            ],
          )),
        ],
      ),
    ));
  }
}
