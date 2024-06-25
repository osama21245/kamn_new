import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/models/medical_model.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/alex_regions_lists.dart';
import '../../../../core/common/custom_map.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/constants/collection_constants.dart';
import '../../../../core/providers/utils.dart';
import '../../../../core/providers/valid.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';

class UpdateMedicalScreen extends ConsumerStatefulWidget {
  final MedicalModel medicalModel;
  const UpdateMedicalScreen({super.key, required this.medicalModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateMedicalScreenState();
}

class _UpdateMedicalScreenState extends ConsumerState<UpdateMedicalScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String region = "Miami";
  TextEditingController? fullname;
  TextEditingController? faceBook;
  TextEditingController? instgram;
  TextEditingController? whatsAppNumber;
  TextEditingController? specialization;
  TextEditingController? dynamicLink;
  TextEditingController? discount;
  TextEditingController? lat;
  TextEditingController? long;
  TextEditingController? about;
  TextEditingController? experience;
  TextEditingController? benefits;
  TextEditingController? education;
  File? logo;

  @override
  void initState() {
    faceBook = TextEditingController(text: widget.medicalModel.faceBook);
    instgram = TextEditingController(text: widget.medicalModel.instgram);
    whatsAppNumber =
        TextEditingController(text: widget.medicalModel.whatAppNum);
    specialization =
        TextEditingController(text: widget.medicalModel.specialization);
    dynamicLink = TextEditingController(text: widget.medicalModel.dynamicLink);
    fullname = TextEditingController(text: widget.medicalModel.name);
    discount =
        TextEditingController(text: widget.medicalModel.discount.toString());
    lat = TextEditingController(text: widget.medicalModel.lat.toString());
    long = TextEditingController(text: widget.medicalModel.long.toString());
    education = TextEditingController(text: widget.medicalModel.education);
    benefits = TextEditingController(text: widget.medicalModel.benefits);
    experience = TextEditingController(text: widget.medicalModel.experience);
    super.initState();
  }

  @override
  void dispose() {
    faceBook!.dispose();
    instgram!.dispose();
    whatsAppNumber!.dispose();
    dynamicLink!.dispose();
    specialization!.dispose();
    fullname!.dispose();
    discount!.dispose();
    lat!.dispose();
    long!.dispose();
    about!.dispose();
    education!.dispose();
    experience!.dispose();
    benefits!.dispose();
    super.dispose();
  }

  updateMedical(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      MedicalModel medicalModel = MedicalModel(
        id: widget.medicalModel.id,
        name: fullname!.text,
        userId: widget.medicalModel.userId,
        image: logo == null ? widget.medicalModel.image : "",
        specialization: specialization!.text,
        discount: discount!.text,
        gallery: widget.medicalModel.gallery,
        long: double.parse(long!.text),
        lat: double.parse(lat!.text),
        rating: 0,
        city: widget.medicalModel.city,
        region: region,
        faceBook: faceBook!.text,
        instgram: instgram!.text,
        whatAppNum: whatsAppNumber!.text,
        dynamicLink: dynamicLink!.text,
        to: widget.medicalModel.to,
        from: widget.medicalModel.from,
        benefits: benefits!.text,
        education: education!.text,
        experience: experience!.text,
      );
      // may cause Erorr null check because logo!
      ref
          .watch(benefitsControllerProvider.notifier)
          .updateMedical(medicalModel, logo, context);
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
                    'Update image',
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
                  onPressed: () => updateMedical(ref),
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
