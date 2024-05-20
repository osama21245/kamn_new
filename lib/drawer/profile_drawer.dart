import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/drawer/widget/custom_drawer_text.dart';
import 'package:kman/featuers/auth/screens/login_screen.dart';
import 'package:kman/featuers/orders/screens/my_reservisions_screens.dart';
import 'package:kman/featuers/serviceprovider/screens/show_serviceprovider_store/serviceprovider_stores_screen.dart';
import '../featuers/auth/controller/auth_controller.dart';
import '../featuers/orders/screens/choose_order_screen.dart';
import '../featuers/orders/screens/service_provider_orders_screen.dart';
import '../featuers/orders/screens/service_provider_reservisions/service_provider_nutrition_reservision_screen.dart';
import '../featuers/orders/screens/service_provider_reservisions/service_provider_sports_reservision_screen.dart';
import '../featuers/play/widget/home/custom_home_uppersection.dart';
import '../featuers/post/screens/add_post_screeen.dart';
import '../featuers/user/screens/inbox/inbox_screen.dart';
import '../featuers/user/screens/myplay_screen.dart';
import '../theme/pallete.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  logOut(WidgetRef ref, String userId) async {
    await ref.watch(authControllerProvider.notifier).logOut();
    FirebaseMessaging.instance.unsubscribeFromTopic("users");
    FirebaseMessaging.instance.unsubscribeFromTopic("users$userId");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(usersProvider);
    Size size = MediaQuery.of(context).size;
    return user == null
        ? Container()
        : Drawer(
            width: size.width * 0.7,
            backgroundColor: Pallete.primaryColorTrans,
            child: SafeArea(
              child: Column(
                children: [
                  user.isAuthanticated == true
                      ? Column(
                          children: [
                            CustomHomeUpperSec(
                              name: user.name,
                              image: user.profilePic,
                              color: Pallete.whiteColor,
                              size: size,
                            ),
                            SizedBox(
                              height: size.height * 0.032,
                            ),
                            InkWell(
                              onTap: () => Get.to(() => MyPlayScreen()),
                              child: CustomDrawerText(
                                size: size,
                                title: "My Play",
                              ),
                            ),
                            if (user.state == "1")
                              InkWell(
                                onTap: () => Get.to(() => AddPostScreen()),
                                child: CustomDrawerText(
                                  size: size,
                                  title: "Add posts",
                                ),
                              ),
                            //   InkWell(
                            //   onTap: () => Get.to(() => InBoxScreen()),
                            //   child: CustomDrawerText(
                            //     size: size,
                            //     title: "Inbox",
                            //   ),
                            // ),
                            //   if(user.state!="1"||user.state!="2"||user.state!="0")
                            //    InkWell(
                            //   onTap: () =>
                            //       Get.to(() => ServiceProviderStoresScreen()),
                            //   child: CustomDrawerText(
                            //     size: size,
                            //     title: "My Store",
                            //   ),
                            // ),
                            InkWell(
                              onTap: () =>
                                  Get.to(() => MyReservisionsScreens()),
                              child: CustomDrawerText(
                                size: size,
                                title: "My Reservisions",
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  Get.to(() => MyReservisionsScreens()),
                              child: CustomDrawerText(
                                size: size,
                                title: "My Reservisions",
                              ),
                            ),
                            if (user.state == "1")
                              InkWell(
                                onTap: () => Get.to(() => ChooseOrderScreen()),
                                child: CustomDrawerText(
                                  size: size,
                                  title: "Orders",
                                ),
                              ),
                            // if (user.state == "1")
                            //   InkWell(
                            //     onTap: () => Get.to(() =>
                            //         const AcceptChooseYourServiceScreen()),
                            //     child: CustomDrawerText(
                            //       size: size,
                            //       title: "Accept service providers",
                            //     ),
                            //   ),
                            if (user.state == "2")
                              InkWell(
                                onTap: () => Get.to(
                                    () => const ServiceProviderOrdersScreen()),
                                child: CustomDrawerText(
                                  size: size,
                                  title: "Orders",
                                ),
                              ),
                            // if (user.state == "1" || user.state == "2")
                            //   InkWell(
                            //     onTap: () =>
                            //         Get.to(() => const UserMakeRequestScreen()),
                            //     child: CustomDrawerText(
                            //       size: size,
                            //       title: "Add service",
                            //     ),
                            //   ),
                            if (user.state == "4")
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceProviderSportsReservisionsScreen())),
                                child: CustomDrawerText(
                                  size: size,
                                  title: "Sports orders",
                                ),
                              ),
                            if (user.state == "5")
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceProviderNutritionReservisionsScreen())),
                                child: CustomDrawerText(
                                  size: size,
                                  title: "Nutrition orders",
                                ),
                              ),
                            InkWell(
                              onTap: () => logOut(ref, user.uid),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.074),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Log out",
                                      style: TextStyle(
                                          fontFamily: "Muller",
                                          fontSize: size.width * 0.047,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            CustomHomeUpperSec(
                              name: user.name,
                              image: user.profilePic,
                              color: Pallete.whiteColor,
                              size: size,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02,
                                  vertical: size.width * 0.03),
                              child: ElevatedButton(
                                onPressed: () => Get.to(() => LoginScreen()),
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontFamily: "Muller",
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.w600),
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(size.width, size.height * 0.06),
                                  backgroundColor: Pallete.fontColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
  }
}
