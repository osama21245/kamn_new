import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:kman/models/coache_model.dart';
import 'package:kman/models/grounds_model.dart';
import '../../../../../HandlingDataView.dart';
import '../../../../../core/common/textfield.dart';
import '../../../../../core/providers/utils.dart';
import '../../../../../core/providers/valid.dart';
import '../../../../../theme/pallete.dart';
import '../../../core/class/alex_regions_lists.dart';
import '../../auth/widget/finsh/custom_finish_middlesec.dart';

class UpdateGroundScreen extends ConsumerStatefulWidget {
  final GroundModel groundMdoel;
  final String collection;
  const UpdateGroundScreen(
      {super.key, required this.groundMdoel, required this.collection});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateGroundScreenState();
}

class _UpdateGroundScreenState extends ConsumerState<UpdateGroundScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String city = "Alexandria";
  String region = "Miami";
  TextEditingController? futures;
  TextEditingController? fullname;
  TextEditingController? groundPlayersNum;
  TextEditingController? lat;
  TextEditingController? long;
  TextEditingController? address;
  TextEditingController? price;
  TextEditingController? phone;
  File? groundImage;

  @override
  void initState() {
    futures = TextEditingController(text: widget.groundMdoel.futuers);
    fullname = TextEditingController(text: widget.groundMdoel.name);
    groundPlayersNum = TextEditingController(
        text: widget.groundMdoel.groundPlayersNum.toString());
    lat = TextEditingController(text: widget.groundMdoel.lat.toString());
    long = TextEditingController(text: widget.groundMdoel.long.toString());

    address = TextEditingController(text: widget.groundMdoel.address);
    price = TextEditingController(text: widget.groundMdoel.price.toString());
    phone = TextEditingController(text: widget.groundMdoel.groundnumber);
    super.initState();
  }

  @override
  void dispose() {
    futures!.dispose();
    fullname!.dispose();
    phone!.dispose();
    price!.dispose();
    address!.dispose();
    lat!.dispose();
    long!.dispose();
    groundPlayersNum!.dispose();
    super.dispose();
  }

  updateGround(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      GroundModel groundModel = GroundModel(
        id: widget.groundMdoel.id,
        name: fullname!.text,
        address: address!.text,
        city: city,
        gallery: widget.groundMdoel.gallery,
        futuers: futures!.text,
        groundOwnerId: widget.groundMdoel.groundOwnerId,
        groundPlayersNum: int.parse(groundPlayersNum!.text),
        groundnumber: phone!.text,
        lat: double.parse(lat!.text),
        long: double.parse(long!.text),
        price: int.parse(price!.text),
        region: region,
        image: groundImage == null ? widget.groundMdoel.image : "",
        rating: 0,
      );
      // may cause Erorr null check because logo!
      ref.watch(playControllerProvider.notifier).updateGround(
          widget.groundMdoel.id,
          widget.collection,
          groundImage,
          groundModel,
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    pickimagefromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        groundImage = File(res.files.first.path!);
      }
      setState(() {});
    }

    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(coachesGymsControllerProvider);

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
                    return validinput(val!, 1, 500, "");
                  },
                  name: "lat",
                  controller: lat!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 1, 500, "");
                  },
                  name: "long",
                  controller: long!,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: ElevatedButton(
                    onPressed: () => updateGround(ref),
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
