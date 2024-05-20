import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import '../../../HandlingDataView.dart';
import '../../../core/class/alex_regions_lists.dart';
import '../../../core/common/custom_map.dart';
import '../../../core/common/textfield.dart';
import '../../../core/constants/collection_constants.dart';
import '../../../core/providers/utils.dart';
import '../../../core/providers/valid.dart';
import '../../../theme/pallete.dart';
import '../../auth/widget/finsh/custom_finish_middlesec.dart';

class AddGroundScreen extends ConsumerStatefulWidget {
  final String collection;
  final bool fromAsk;
  const AddGroundScreen(
      {super.key, required this.collection, required this.fromAsk});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddGroundScreenState();
}

class _AddGroundScreenState extends ConsumerState<AddGroundScreen> {
  String city = "Cairo";
  String region = "Miami";
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? futures;
  TextEditingController? fullname;
  TextEditingController? groundPlayersNum;
  TextEditingController? address;
  TextEditingController? price;
  TextEditingController? phone;
  File? groundImage;
  //List<File> cvsList = [];
  @override
  void initState() {
    futures = TextEditingController();
    groundPlayersNum = TextEditingController();
    fullname = TextEditingController();
    address = TextEditingController();
    phone = TextEditingController();
    price = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    futures!.dispose();
    groundPlayersNum!.dispose();
    address!.dispose();
    fullname!.dispose();
    phone!.dispose();
    price!.dispose();
    super.dispose();
  }

  setGround(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      ref.watch(playControllerProvider.notifier).setGround(
          address!.text,
          int.parse(price!.text),
          fullname!.text,
          phone!.text,
          futures!.text,
          groundImage,
          context,
          widget.collection,
          int.parse(groundPlayersNum!.text),
          city,
          region,
          widget.fromAsk);
    }
  }

  List<String> cityList = [
    'Cairo',
    'Alex',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(playControllerProvider);
    pickimagefromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        groundImage = File(res.files.first.path!);
      }
      setState(() {});
    }

    return Scaffold(
      body: Form(
        key: formstate,
        child: SafeArea(
            child: HandlingDataView(
          statusRequest: statusRequest,
          widget: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.07, vertical: size.height * 0.05),
            child: ListView(
              children: [
                Text(
                  "Finish Ground Setup",
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
                  "Please complete the following information to \n Fisnsh Your Ground Setup",
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
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 4, 200, "");
                  },
                  name: "phone",
                  controller: phone!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 1, 30, "");
                  },
                  name: "address",
                  controller: address!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 1, 200, "");
                  },
                  name: "price",
                  controller: price!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 4, 200, "");
                  },
                  name: "futures",
                  controller: futures!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 4, 200, "");
                  },
                  name: "Full Name",
                  controller: fullname!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 1, 200, "");
                  },
                  name: "groundPlayersNum",
                  controller: groundPlayersNum!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Pallete.fontColor),
                      borderRadius: BorderRadius.circular(size.width * 0.02)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: DropdownButton(
                      underline: Text(""),
                      style: TextStyle(
                          color: Pallete.lightgreyColor2,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.037,
                          fontWeight: FontWeight.w500),
                      isExpanded: true,
                      value: city,
                      focusColor: const Color.fromARGB(0, 255, 192, 192),
                      items: cityList.map((con) {
                        return DropdownMenuItem(
                          value: con,
                          child: Text(con),
                          onTap: () {
                            if (con == cityList[0]) {
                              city = cityList[0];
                            }
                            setState(() {});
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          city = value!;
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
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                      items: alexandriaRegionsForAdd.map((region) {
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
                  padding: EdgeInsets.only(
                      left: size.height * 0.02, bottom: size.height * 0.02),
                  child: CustomFinishMiddleSec(
                      color: Pallete.fontColor,
                      collection: "Finish Submet",
                      size: size),
                ),
                groundImage == null
                    ? Container(
                        height: size.height * 0.15,
                        width: size.width,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Pallete.greyColor, width: 2),
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02)),
                        child: Center(
                            child: Text(
                          "Enter Ground Images",
                          style: TextStyle(
                              color: Pallete.greyColor,
                              fontFamily: "Muller",
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w600),
                        )))
                    : Image.file(groundImage!),
                SizedBox(
                  height: size.height * 0.023,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: ElevatedButton(
                    onPressed: () => pickimagefromGallery(context),
                    child: Text(
                      'Add Ground image',
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        fixedSize: Size(size.width, size.height * 0.06),
                        backgroundColor: groundImage == null
                            ? Pallete.greyColor
                            : Pallete.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02))),
                  ),
                ),
                const CustomGoogleMaps(
                  collection: Collections.playCollection,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: ElevatedButton(
                    onPressed: () => setGround(ref),
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
      ),
    );
  }
}
