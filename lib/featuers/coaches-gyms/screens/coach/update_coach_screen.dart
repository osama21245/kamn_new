import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/models/coache_model.dart';
import '../../../../../HandlingDataView.dart';
import '../../../../../core/common/textfield.dart';
import '../../../../../core/providers/utils.dart';
import '../../../../../core/providers/valid.dart';
import '../../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';

class UpdateCoachScreen extends ConsumerStatefulWidget {
  final CoacheModel coacheModel;
  const UpdateCoachScreen({super.key, required this.coacheModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateCoachScreenState();
}

class _UpdateCoachScreenState extends ConsumerState<UpdateCoachScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? benefits;
  TextEditingController? education;
  TextEditingController? fullname;
  TextEditingController? experince;
  TextEditingController? whatssAppnum;
  TextEditingController? instgramLink;
  TextEditingController? facebookLink;
  TextEditingController? dynamicLink;
  TextEditingController? categoriry;
  File? coachImage;

  @override
  void initState() {
    facebookLink = TextEditingController(text: widget.coacheModel.faceBook);
    instgramLink = TextEditingController(text: widget.coacheModel.instgram);
    whatssAppnum = TextEditingController(text: widget.coacheModel.whatsAppNum);
    experince = TextEditingController(text: widget.coacheModel.experience);
    dynamicLink = TextEditingController(text: widget.coacheModel.dynamicLink);
    fullname = TextEditingController(text: widget.coacheModel.name);

    categoriry =
        TextEditingController(text: widget.coacheModel.categoriry.toString());
    benefits =
        TextEditingController(text: widget.coacheModel.benefits.toString());
    education = TextEditingController(text: widget.coacheModel.education);
    super.initState();
  }

  @override
  void dispose() {
    facebookLink!.dispose();
    instgramLink!.dispose();
    whatssAppnum!.dispose();
    dynamicLink!.dispose();
    experince!.dispose();
    fullname!.dispose();
    education!.dispose();
    benefits!.dispose();
    categoriry!.dispose();
    super.dispose();
  }

  updateCoach(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      CoacheModel coachModel = CoacheModel(
          id: widget.coacheModel.id,
          name: fullname!.text,
          benefits: benefits!.text,
          categoriry: categoriry!.text,
          gallery: widget.coacheModel.gallery,
          education: education!.text,
          experience: experince!.text,
          onlineSpecial: widget.coacheModel.onlineSpecial,
          onlinepoints: widget.coacheModel.onlinepoints,
          onlineprices: widget.coacheModel.onlineprices,
          onlineplanDescriptions: widget.coacheModel.onlineplanDescriptions,
          onlinePlanName: widget.coacheModel.onlinePlanName,
          onlinediscount: widget.coacheModel.onlinediscount,
          onlineisGroup: widget.coacheModel.onlineisGroup,
          onlineReservisionTimes: widget.coacheModel.onlineReservisionTimes,
          offlineSpecial: widget.coacheModel.offlineSpecial,
          offlinepoints: widget.coacheModel.offlinepoints,
          offlineprices: widget.coacheModel.offlineprices,
          offlineplanDescriptions: widget.coacheModel.offlineplanDescriptions,
          offlinePlanName: widget.coacheModel.offlinePlanName,
          offlinediscount: widget.coacheModel.offlinediscount,
          offlineisGroup: widget.coacheModel.offlineisGroup,
          offlineReservisionTimes: widget.coacheModel.offlineReservisionTimes,
          userId: widget.coacheModel.userId,
          image: coachImage == null ? widget.coacheModel.image : "",
          rating: 0,
          faceBook: facebookLink!.text,
          instgram: instgramLink!.text,
          whatsAppNum: whatssAppnum!.text,
          dynamicLink: dynamicLink!.text);
      // may cause Erorr null check because logo!
      ref
          .watch(coachesGymsControllerProvider.notifier)
          .updateCoach(coachModel, coachImage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    pickimagefromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        coachImage = File(res.files.first.path!);
      }
      setState(() {});
    }

    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(coachesGymsControllerProvider);
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
                "Finish Coach Setup",
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
                "Please complete the following information to \n Fisnsh Your Coach Setup",
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
                        validator: (val) {
                          return validinput(val!, 4, 500, "");
                        },
                        name: "categoriry",
                        controller: categoriry!,
                        color: Pallete.lightgreyColor2,
                      ),
                      SizedBox(
                        height: size.height * 0.023,
                      ),
                      TextFiled(
                        validator: (val) {
                          return validinput(val!, 4, 500, "");
                        },
                        name: "education",
                        controller: education!,
                        color: Pallete.lightgreyColor2,
                      ),
                      SizedBox(
                        height: size.height * 0.023,
                      ),
                      TextFiled(
                        validator: (val) {
                          return validinput(val!, 4, 500, "");
                        },
                        name: "experince",
                        controller: experince!,
                        color: Pallete.lightgreyColor2,
                      ),
                      SizedBox(
                        height: size.height * 0.023,
                      ),
                      TextFiled(
                        validator: (val) {
                          return validinput(val!, 4, 500, "");
                        },
                        name: "benefits",
                        controller: benefits!,
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
              Padding(
                padding: EdgeInsets.only(
                    left: size.height * 0.02, bottom: size.height * 0.02),
                child: CustomFinishMiddleSec(
                    color: Pallete.fontColor,
                    collection: "Finish Submet",
                    size: size),
              ),
              coachImage == null
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
                        "Enter Coach Images",
                        style: TextStyle(
                            color: Pallete.greyColor,
                            fontFamily: "Muller",
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w600),
                      )))
                  : Image.file(coachImage!),
              SizedBox(
                height: size.height * 0.023,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => pickimagefromGallery(context),
                  child: Text(
                    'Add Coach image',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(size.width, size.height * 0.06),
                      backgroundColor: coachImage != null
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
                  onPressed: () => updateCoach(ref),
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
