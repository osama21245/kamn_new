import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/alex_regions_lists.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/utils.dart';
import '../../../../core/providers/valid.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';
import '../../controller/coaches-gyms_controller.dart';

class AddgymsLocationsScreen extends ConsumerStatefulWidget {
  final String gymId;
  final String image;
  const AddgymsLocationsScreen(
      {super.key, required this.gymId, required this.image});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddgymsLocationsScreenState();
}

class _AddgymsLocationsScreenState
    extends ConsumerState<AddgymsLocationsScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? fullname;

  TextEditingController? whatssAppnum;
  TextEditingController? lat;
  TextEditingController? long;
  TextEditingController? address;
  TextEditingController? instgramLink;
  TextEditingController? facebookLink;
  TextEditingController? dynamicLink;
  String region = "Miami";
  String gym = "Mix";
  List<File> galleryList = [];

  @override
  void initState() {
    whatssAppnum = TextEditingController();
    instgramLink = TextEditingController();
    facebookLink = TextEditingController();
    dynamicLink = TextEditingController();
    fullname = TextEditingController();
    lat = TextEditingController();
    long = TextEditingController();
    address = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    dynamicLink!.dispose();
    facebookLink!.dispose();
    whatssAppnum!.dispose();
    lat!.dispose();
    long!.dispose();
    address!.dispose();
    instgramLink!.dispose();
    fullname!.dispose();

    super.dispose();
  }

  setGymLocation(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      ref.watch(coachesGymsControllerProvider.notifier).setGymsLocations(
            context,
            fullname!.text,
            widget.gymId,
            address!.text,
            widget.image,
            widget.gymId,
            double.parse(lat!.text),
            double.parse(long!.text),
            facebookLink!.text,
            dynamicLink!.text,
            region,
            gym == "Mix" ? true : false,
            galleryList,
            instgramLink!.text,
            whatssAppnum!.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    pickimagesfromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        galleryList.add(File(res.files.first.path!));
      }
      setState(() {});
    }

    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(coachesGymsControllerProvider);
    List<String> gymList = [
      'Mix',
      'Separeted',
    ];

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
                  "Finish Gym Setup",
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
                  "Please complete the following information to \n Fisnsh Your Gym Setup",
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
                    return validinput(val!, 1, 500, "");
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
                    return validinput(val!, 4, 500, "");
                  },
                  name: "Full Name",
                  controller: fullname!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  name: "whatAppNumber",
                  controller: whatssAppnum!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.016,
                ),
                TextFiled(
                  name: "instgramLink",
                  controller: instgramLink!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.016,
                ),
                TextFiled(
                  name: "faceBookLink",
                  controller: facebookLink!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.016,
                ),
                TextFiled(
                  name: "dynamicLink",
                  controller: dynamicLink!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.016,
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
                      value: gym,
                      focusColor: const Color.fromARGB(0, 255, 192, 192),
                      items: gymList.map((gen) {
                        return DropdownMenuItem(
                          value: gen,
                          child: Text(gen),
                          onTap: () {
                            if (gen == gymList[0]) {
                              gym = gymList[0];
                            } else if (gen == gymList[1]) {
                              gym = gymList[1];
                            }
                            setState(() {});
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          gym = value!;
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
                SizedBox(
                  height: size.height * 0.023,
                ),
                galleryList.isNotEmpty
                    ? Container(
                        height: size.height * 0.3,
                        width: size.width,
                        child: GridView.builder(
                            itemCount: galleryList.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.54, crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return Image.file(
                                galleryList[index],
                              );
                            }),
                      )
                    : Container(
                        height: size.height * 0.2,
                        width: size.width,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Pallete.greyColor, width: 2),
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02)),
                        child: Center(
                            child: Text(
                          "Enter Gallery Images",
                          style: TextStyle(
                              color: Pallete.greyColor,
                              fontFamily: "Muller",
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w600),
                        ))),
                SizedBox(
                  height: size.height * 0.023,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: ElevatedButton(
                    onPressed: () => pickimagesfromGallery(context),
                    child: Text(
                      'Add cv images',
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        fixedSize: Size(size.width, size.height * 0.06),
                        backgroundColor: galleryList.isNotEmpty
                            ? Pallete.primaryColor
                            : Pallete.greyColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: ElevatedButton(
                    onPressed: () => setGymLocation(ref),
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
