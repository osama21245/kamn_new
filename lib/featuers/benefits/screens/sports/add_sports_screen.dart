import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/common/custom_map.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/alex_regions_lists.dart';
import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/utils.dart';
import '../../../../core/providers/valid.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';

class AddSportsScreen extends ConsumerStatefulWidget {
  final bool fromAsk;
  const AddSportsScreen({super.key, required this.fromAsk});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddSportsScreenState();
}

class _AddSportsScreenState extends ConsumerState<AddSportsScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String region = "Miami";
  TextEditingController? fullname;
  TextEditingController? faceBook;
  TextEditingController? instgram;
  TextEditingController? whatsAppNumber;
  TextEditingController? dynamicLink;
  TextEditingController? discount;
  TextEditingController? about;
  List<File> galleryList = [];
  File? logo;

  @override
  void initState() {
    faceBook = TextEditingController();
    instgram = TextEditingController();
    whatsAppNumber = TextEditingController();
    dynamicLink = TextEditingController();
    fullname = TextEditingController();
    discount = TextEditingController();
    about = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    faceBook!.dispose();
    instgram!.dispose();
    whatsAppNumber!.dispose();
    dynamicLink!.dispose();
    fullname!.dispose();
    discount!.dispose();
    about!.dispose();
    super.dispose();
  }

  setSport(WidgetRef ref) {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      if (mounted) {
        // Check if the widget is still mounted
        ref.watch(benefitsControllerProvider.notifier).setSports(
            context,
            logo,
            fullname!.text,
            about!.text,
            faceBook!.text,
            instgram!.text,
            whatsAppNumber!.text,
            dynamicLink!.text,
            int.parse(discount!.text),
            galleryList,
            region,
            widget.fromAsk);
      } else {
        // Handle the case where the widget is already disposed
        print('Widget is disposed, cannot set sports.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    pickimagefromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        logo = File(res.files.first.path!);
        setState(() {});
      }
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
                "Finish Sport Setup",
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
                "Please complete the following information to \n Fisnsh Your Sport Setup",
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
                          return validinput(val!, 1, 1000, "");
                        },
                        name: "about",
                        controller: about!,
                        color: Pallete.lightgreyColor2,
                      ),
                      SizedBox(
                        height: size.height * 0.023,
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
                controller: faceBook!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              TextFiled(
                name: "Your instgram page (Optional)",
                controller: instgram!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              TextFiled(
                keytypeisnumber: true,
                name: "Your whatsApp Number (Optional)",
                controller: whatsAppNumber!,
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
                        "Enter Sports Images",
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
                    'Add Sports image',
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
                    'Add Gallery images',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const CustomGoogleMaps(
                collection: Collections.sportsCollection,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => setSport(ref),
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
