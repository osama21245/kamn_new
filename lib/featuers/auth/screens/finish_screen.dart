import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/auth/widget/finsh/custom_finish_middlesec.dart';
import 'package:kman/theme/pallete.dart';
import '../../../core/common/textfield.dart';

class FinishScreen extends ConsumerStatefulWidget {
  final String? phone;
  final String uid;

  const FinishScreen({super.key, this.phone, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FinishScreenState();
}

class _FinishScreenState extends ConsumerState<FinishScreen> {
  // TextEditingController? password;
  // TextEditingController? confirmPassword;
  TextEditingController? fullname;
  TextEditingController? age;
  String gender = "female";
  String country = "Egypt";
  String region = "Abis";
  String city = "Cairo";
  @override
  void initState() {
    age = TextEditingController();
    // password = TextEditingController();
    // confirmPassword = TextEditingController();
    fullname = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    age!.dispose();
    // password!.dispose();
    // confirmPassword!.dispose();
    fullname!.dispose();
    super.dispose();
  }

  createAccountWithEmailAndPassword(WidgetRef ref) {
    ref.watch(authControllerProvider.notifier).setUserData(
        fullname!.text,
        widget.uid,
        widget.phone ?? "",
        age!.text,
        city,
        region,
        country,
        gender,
        context);
  }

  @override
  Widget build(BuildContext context) {
    List<String> genderList = [
      'female',
      'male',
    ];
    List<String> cityList = [
      'Cairo',
      'Alex',
    ];
    List<String> countryList = ['Egypt', "Sudia"];
    final List<String> alexandriaRegions = [
      "Abis",
      "Agami",
      "Al-Amreya",
      "Al-Awayed",
      "Al-Bacilia",
      "Al-Bahria",
      "Al-Bostan",
      "Al-Dikirnis",
      "Al-Gomrok",
      "Al-Gomrok El-Khadra",
      "Al-Hadara",
      "Al-Hamam",
      "Al-Haram",
      "Al-Ibrahimiya",
      "Al-Kabbary",
      "Al-Khayam",
      "Al-Laban",
      // Add more regions here...
    ];
    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(authControllerProvider);
    return Scaffold(
      body: SafeArea(
          child: HandlingDataView(
        statusRequest: statusRequest,
        widget: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.07, vertical: size.height * 0.05),
          child: ListView(
            children: [
              Text(
                "Finish Account Setup",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Pallete.fontColor,
                    fontFamily: "Muller",
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: size.height * 0.012,
              ),
              Text(
                "Please complete the following information to \n Fisnsh Your Account Setup",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Pallete.greyColor,
                    fontFamily: "Muller",
                    fontSize: size.width * 0.037,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: size.height * 0.016,
              ),
              // TextFiled(
              //   name: "Password",
              //   controller: password!,
              //   color: Pallete.lightgreyColor2,
              // ),
              // SizedBox(
              //   height: size.height * 0.023,
              // ),
              // TextFiled(
              //   name: "Confirm Password",
              //   controller: confirmPassword!,
              //   color: Pallete.lightgreyColor2,
              // ),
              SizedBox(
                height: size.height * 0.023,
              ),
              TextFiled(
                name: "Full Name",
                controller: fullname!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              TextFiled(
                name: "Age (17,18,..)",
                controller: age!,
                color: Pallete.lightgreyColor2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: CustomFinishMiddleSec(
                    color: Pallete.fontColor,
                    collection: "Account information",
                    size: size),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Pallete.fontColor),
                    borderRadius: BorderRadius.circular(size.width * 0.02)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: DropdownButton(
                    underline: Text(""),
                    style: TextStyle(
                        color: Pallete.lightgreyColor2,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.037,
                        fontWeight: FontWeight.w500),
                    isExpanded: true,
                    value: gender,
                    focusColor: const Color.fromARGB(0, 255, 192, 192),
                    items: genderList.map((gen) {
                      return DropdownMenuItem(
                        value: gen,
                        child: Text(gen),
                        onTap: () {
                          if (gen == genderList[0]) {
                            gender = genderList[0];
                          } else if (gen == genderList[1]) {
                            gender = genderList[1];
                          }
                          setState(() {});
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Pallete.fontColor),
                    borderRadius: BorderRadius.circular(size.width * 0.02)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: DropdownButton(
                    underline: Text(""),
                    style: TextStyle(
                        color: Pallete.lightgreyColor2,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.037,
                        fontWeight: FontWeight.w500),
                    isExpanded: true,
                    value: city,
                    focusColor: Colors.transparent,
                    items: cityList.map((cit) {
                      return DropdownMenuItem(
                        value: cit,
                        child: Text(cit),
                        onTap: () {
                          if (cit == cityList[0]) {
                            city = cityList[0];
                          } else if (cit == cityList[1]) {
                            city = cityList[1];
                          }
                          setState(() {});
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      city = value!;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Pallete.fontColor),
                    borderRadius: BorderRadius.circular(size.width * 0.02)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: DropdownButton(
                    underline: Text(""),
                    style: TextStyle(
                        color: Pallete.lightgreyColor2,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.037,
                        fontWeight: FontWeight.w500),
                    isExpanded: true,
                    value: country,
                    focusColor: const Color.fromARGB(0, 255, 192, 192),
                    items: countryList.map((con) {
                      return DropdownMenuItem(
                        value: con,
                        child: Text(con),
                        onTap: () {
                          if (con == countryList[0]) {
                            country = countryList[0];
                          }
                          setState(() {});
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        country = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Pallete.fontColor),
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: DropdownButton(
                    underline: Text(""),
                    style: TextStyle(
                      color: Pallete.lightgreyColor2,
                      fontFamily: "Muller",
                      fontSize: size.width * 0.037,
                      fontWeight: FontWeight.w500,
                    ),
                    isExpanded: true,
                    value: region,
                    focusColor: const Color.fromARGB(0, 255, 192, 192),
                    items: alexandriaRegions.map((region) {
                      return DropdownMenuItem(
                        value: region,
                        child: Text(region),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        region = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => createAccountWithEmailAndPassword(ref),
                  child: Text(
                    'Finish',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(size.width, size.height * 0.06),
                      backgroundColor: Pallete.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
