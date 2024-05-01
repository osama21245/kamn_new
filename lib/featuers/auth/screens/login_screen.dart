import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/auth/screens/check_screen.dart';
import 'package:kman/featuers/auth/screens/finish_google_screen.dart';
import 'package:kman/featuers/auth/screens/finish_screen.dart';
import 'package:kman/featuers/auth/screens/takenum_screen.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../../core/constants/services/services.dart';
import '../../../theme/pallete.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController? email;
  TextEditingController? password;
  StatusRequest statusRequest = StatusRequest.success;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email!.dispose();
    password!.dispose();
    super.dispose();
  }

  signInWithEmailAndPassword(WidgetRef ref) {
    ref
        .watch(authControllerProvider.notifier)
        .signInWithEmailAndPassword(email!.text, password!.text, context);
  }

  signInWithGoogle(WidgetRef ref, BuildContext context, String status) {
    ref
        .watch(authControllerProvider.notifier)
        .signinWithGoogle(context, true, status, "", "", "");
  }

  goTo() {
    MyServices myServices = Get.find();
    if (myServices.sharedPreferences.getString("check") == "1") {
      return signInWithGoogle(ref, context, "0");
    } else {
      print(myServices.sharedPreferences.getString("check"));
      Get.to(() => FinishGoogleScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    statusRequest = ref.watch(authControllerProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: HandlingDataView(
          statusRequest: statusRequest,
          widget: SafeArea(
              child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.1,
                right: size.width * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/page-1/images/kamn_noBG.png",
                    height: size.height * 0.28,
                  ),
                  Text(
                    'Welcome Back , Log in !',
                    style: TextStyle(
                        color: Pallete.fontColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: size.height * 0.046,
                  ),
                  // TextFiled(
                  //   name: "Email or Phone Number",
                  //   controller: email!,
                  //   color: Pallete.lightgreyColor2,
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.02,
                  // ),
                  // TextFiled(
                  //   name: "Password",
                  //   controller: password!,
                  //   ispassword: true,
                  //   color: Pallete.lightgreyColor2,
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       'Forgot your password?',
                  //       style: TextStyle(
                  //           color: const Color.fromARGB(255, 34, 34, 34),
                  //           fontFamily: "Muller",
                  //           fontSize: size.width * 0.03,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.03,
                  // ),
                  // ElevatedButton(
                  //   onPressed: () => signInWithEmailAndPassword(ref),
                  //   child: Text(
                  //     'Log in',
                  //     style: TextStyle(
                  //         color: Pallete.whiteColor,
                  //         fontFamily: "Muller",
                  //         fontSize: size.width * 0.05,
                  //         fontWeight: FontWeight.w600),
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //       fixedSize: Size(size.width, size.height * 0.06),
                  //       backgroundColor: Pallete.primaryColor,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(size.width * 0.02))),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Don't Have an account?",
                  //       style: TextStyle(
                  //           color: Pallete.fontColor,
                  //           fontFamily: "Muller",
                  //           fontSize: size.width * 0.03,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Text(
                  //         "Register Now",
                  //         style: TextStyle(
                  //             color: Pallete.fontColor,
                  //             fontFamily: "Muller",
                  //             fontSize: size.width * 0.03,
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //     ),
                  //   ],)
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.03,
                  // ),
                  // Text(
                  //   "Or log in with",
                  //   style: TextStyle(
                  //       color: Pallete.blackColor,
                  //       fontFamily: "Muller",
                  //       fontSize: size.width * 0.03,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  ElevatedButton(
                    onPressed: () => Get.to(TakeNumScren()),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/page-1/images/kamn_splash.png",
                          fit: BoxFit.contain,
                        ),
                        Text(
                          'Register Now',
                          style: TextStyle(
                              color: Pallete.whiteColor,
                              fontFamily: "Muller",
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.6, size.height * 0.04),
                        backgroundColor: Pallete.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02))),
                  ),
                  SizedBox(
                    height: size.width * 0.02,
                  ),
                  SignInButton(
                    Buttons.google,
                    onPressed: () => goTo(),
                  ),
                  //Spacer(),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "By using KAMN you agree to our",
                  //           style: TextStyle(
                  //               color: Pallete.blackColor,
                  //               fontFamily: "Muller",
                  //               fontSize: size.width * 0.03,
                  //               fontWeight: FontWeight.w400),
                  //         ),
                  //         Text(
                  //           "Terms of Service",
                  //           style: TextStyle(
                  //               color: Pallete.blackColor,
                  //               fontFamily: "Muller",
                  //               fontSize: size.width * 0.03,
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //         Text(
                  //           "and",
                  //           style: TextStyle(
                  //               color: Pallete.blackColor,
                  //               fontFamily: "Muller",
                  //               fontSize: size.width * 0.03,
                  //               fontWeight: FontWeight.w400),
                  //         ),
                  //       ],
                  //     ),
                  //     Text(
                  //       "Privacy Policy",
                  //       style: TextStyle(
                  //           color: Pallete.blackColor,
                  //           fontFamily: "Muller",
                  //           fontSize: size.width * 0.03,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                ],
              ),
            ),
          )),
        ));
  }
}
