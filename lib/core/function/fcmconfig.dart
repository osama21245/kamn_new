import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/coaches-gyms/screens/coaches-gyms_home_screen.dart';
import 'package:kman/featuers/orders/screens/service_provider_orders_screen.dart';
import 'package:kman/homemain.dart';

import '../../featuers/orders/screens/my_reservisions_screens.dart';

requestPermissionNotification() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

fcmconfig(BuildContext context) {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("onMessageOpenedApp: $message");
    // Handle notification when the app is in the background and opened via notification
    String messageTitle = message.notification!.title.toString();
    print("${messageTitle}");

    if (messageTitle == "New customer") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyReservisionsScreens(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoachesGymsHomeScreen(),
        ),
      );
    }
  });

  FirebaseMessaging.onMessage.listen((message) {
    FlutterRingtonePlayer().playNotification();
    Get.snackbar(message.notification!.title!, message.notification!.body!);
  });

  // FirebaseMessaging.onBackgroundMessage((message) async {
  //   print("onBackgroundMessage: $message");
  //   // Handle notification when the app is terminated and opened via notification
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => HomeMain(),
  //     ),
  //   );
  // });
}
