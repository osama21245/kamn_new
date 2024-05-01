import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';

class OnlineSuport extends ConsumerWidget {
  const OnlineSuport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    openWhatsApp(WidgetRef ref, String phone, BuildContext context) {
      ref
          .watch(coachesGymsControllerProvider.notifier)
          .openWhatsApp(phone, context);
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/page-1/images/kamn_noBG.png"),
            Text(
              "For help or any questions call us \n on whatsApp",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: size.height * 0.0015,
                  fontFamily: "Muller",
                  color: Colors.black,
                  fontSize: size.width * 0.04),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            OutlinedButton(
              onPressed: () => openWhatsApp(ref, "01556420645", context),
              child: Text("WhatsApp"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 25)),
            )
          ],
        ),
      )),
    );
  }
}
