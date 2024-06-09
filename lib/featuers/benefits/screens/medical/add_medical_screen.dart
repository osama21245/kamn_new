import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/alex_regions_lists.dart';
import '../../../../core/common/custom_map.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/constants/collection_constants.dart';
import '../../../../core/providers/utils.dart';
import '../../../../core/providers/valid.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';

class AddMedicalScreen extends ConsumerStatefulWidget {
  final bool fromAsk;
  const AddMedicalScreen({super.key, required this.fromAsk});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddMedicalScreenState();
}

class _AddMedicalScreenState extends ConsumerState<AddMedicalScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? experience;
  TextEditingController? benefits;
  TextEditingController? fullname;
  TextEditingController? link;
  TextEditingController? discount;
  TextEditingController? specialization;
  TextEditingController? education;
  TextEditingController? whatssAppnum;
  TextEditingController? instgramLink;
  TextEditingController? facebookLink;
  TextEditingController? dynamicLink;
  List<File> galleryList = [];
  File? logo;
  String region = "Miami";

  @override
  void initState() {
    experience = TextEditingController();
    benefits = TextEditingController();
    link = TextEditingController();
    fullname = TextEditingController();
    discount = TextEditingController();
    specialization = TextEditingController();
    education = TextEditingController();
    whatssAppnum = TextEditingController();
    instgramLink = TextEditingController();
    facebookLink = TextEditingController();
    dynamicLink = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    experience!.dispose();
    link!.dispose();
    benefits!.dispose();
    fullname!.dispose();
    discount!.dispose();
    specialization!.dispose();
    education!.dispose();
    dynamicLink!.dispose();
    facebookLink!.dispose();
    whatssAppnum!.dispose();
    instgramLink!.dispose();
    super.dispose();
  }

  setMedical(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      ref.watch(benefitsControllerProvider.notifier).setMedical(
          context,
          logo,
          fullname!.text,
          experience!.text,
          benefits!.text,
          specialization!.text,
          education!.text,
          discount!.text,
          facebookLink!.text,
          region,
          dynamicLink!.text,
          instgramLink!.text,
          whatssAppnum!.text,
          galleryList,
          widget.fromAsk);
    }
  }

  @override
  Widget build(BuildContext context) {
    pickimagefromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        logo = File(res.files.first.path!);
      }
      setState(() {});
    }

    pickimagesfromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        galleryList.add(File(res.files.first.path!));
      }
      setState(() {});
    }

    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(benefitsControllerProvider);

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
                "Finish Medical Setup",
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
                "Please complete the following information to \n Fisnsh Your Medical Setup",
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
              Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFiled(
                        validator: (val) {
                          return validinput(val!, 1, 500, "");
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
                          return validinput(val!, 1, 500, "");
                        },
                        name: "specialization",
                        controller: specialization!,
                        color: Pallete.lightgreyColor2,
                      ),
                      SizedBox(
                        height: size.height * 0.016,
                      ),
                      TextFiled(
                        validator: (val) {
                          return validinput(val!, 1, 500, "");
                        },
                        name: "benefits",
                        controller: benefits!,
                        color: Pallete.lightgreyColor2,
                      ),
                      SizedBox(
                        height: size.height * 0.016,
                      ),
                      TextFiled(
                        validator: (val) {
                          return validinput(val!, 1, 500, "");
                        },
                        name: "experience",
                        controller: experience!,
                        color: Pallete.lightgreyColor2,
                      ),
                      SizedBox(
                        height: size.height * 0.016,
                      ),
                      TextFiled(
                        validator: (val) {
                          return validinput(val!, 1, 500, "");
                        },
                        name: "education",
                        controller: education!,
                        color: Pallete.lightgreyColor2,
                      ),
                      SizedBox(
                        height: size.height * 0.016,
                      ),
                      TextFiled(
                        keytypeisnumber: true,
                        validator: (val) {
                          return validinput(val!, 1, 500, "int");
                        },
                        name: "discount",
                        controller: discount!,
                        color: Pallete.lightgreyColor2,
                      ),
                    ],
                  )),
              SizedBox(
                height: size.height * 0.023,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.height * 0.02, bottom: size.height * 0.02),
                child: CustomFinishMiddleSec(
                    color: Pallete.fontColor,
                    collection: "Optional",
                    size: size),
              ),
              TextFiled(
                name: "Your facebook page (Optional)",
                controller: facebookLink!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              TextFiled(
                name: "Your instgram page (Optional)",
                controller: instgramLink!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              TextFiled(
                keytypeisnumber: true,
                name: "Your whatsApp Number (Optional)",
                controller: whatssAppnum!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              TextFiled(
                name: "Any other social link (Optional)",
                controller: dynamicLink!,
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
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: DropdownButton(
                    underline: const Text(""),
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
              logo == null
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
                        "Enter Medical Images",
                        style: TextStyle(
                            color: Pallete.greyColor,
                            fontFamily: "Muller",
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w600),
                      )))
                  : Image.file(logo!),
              SizedBox(
                height: size.height * 0.023,
              ),
              galleryList.isNotEmpty
                  ? SizedBox(
                      height: size.height * 0.3,
                      width: size.width,
                      child: GridView.builder(
                          itemCount: galleryList.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                        "Enter Cv Images",
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
                  onPressed: () => pickimagefromGallery(context),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(size.width, size.height * 0.06),
                      backgroundColor: logo == null
                          ? Pallete.greyColor
                          : Pallete.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                  child: Text(
                    'Add Medical image',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => pickimagesfromGallery(context),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(size.width, size.height * 0.06),
                      backgroundColor: galleryList.isNotEmpty
                          ? Pallete.primaryColor
                          : Pallete.greyColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                  child: Text(
                    'Add cv images',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const CustomGoogleMaps(
                collection: Collections.medicalCollection,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => setMedical(ref),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(size.width, size.height * 0.06),
                      backgroundColor: Pallete.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                  child: Text(
                    'Finish',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
