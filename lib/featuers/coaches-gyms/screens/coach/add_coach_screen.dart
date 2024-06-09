import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/common/social_textfield.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/utils.dart';
import '../../../../core/providers/valid.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';
import '../../controller/coaches-gyms_controller.dart';

class AddCoachScreen extends ConsumerStatefulWidget {
  final bool fromAsk;
  const AddCoachScreen({super.key, required this.fromAsk});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends ConsumerState<AddCoachScreen> {
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
  List<File> cvsList = [];
  @override
  void initState() {
    benefits = TextEditingController();
    education = TextEditingController();
    experince = TextEditingController();
    fullname = TextEditingController();
    whatssAppnum = TextEditingController();
    instgramLink = TextEditingController();
    facebookLink = TextEditingController();
    dynamicLink = TextEditingController();
    categoriry = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    benefits!.dispose();
    experince!.dispose();
    education!.dispose();
    fullname!.dispose();
    dynamicLink!.dispose();
    facebookLink!.dispose();
    whatssAppnum!.dispose();
    instgramLink!.dispose();
    categoriry!.dispose();
    super.dispose();
  }

  seCoach(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      ref.watch(coachesGymsControllerProvider.notifier).setCoache(
          fullname!.text,
          context,
          education!.text,
          facebookLink!.text,
          dynamicLink!.text,
          instgramLink!.text,
          whatssAppnum!.text,
          categoriry!.text,
          experince!.text,
          coachImage,
          cvsList,
          benefits!.text,
          widget.fromAsk);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(usersProvider)!;
    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(coachesGymsControllerProvider);
    pickimagesfromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        cvsList.add(File(res.files.first.path!));
      }
      setState(() {});
    }

    pickimagefromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        coachImage = File(res.files.first.path!);
      }
      setState(() {});
    }

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
              SocialTextFiled(
                name: "Your facebook page (Optional)",
                controller: facebookLink!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              SocialTextFiled(
                name: "Your instgram page (Optional)",
                controller: instgramLink!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              SocialTextFiled(
                keytypeisnumber: true,
                name: "Your whatsApp Number (Optional)",
                controller: whatssAppnum!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              SocialTextFiled(
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
              cvsList.isNotEmpty
                  ? SizedBox(
                      height: size.height * 0.3,
                      width: size.width,
                      child: GridView.builder(
                          itemCount: cvsList.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.54, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Image.file(
                              cvsList[index],
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
                  onPressed: () => pickimagesfromGallery(context),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(size.width, size.height * 0.06),
                      backgroundColor: cvsList.isNotEmpty
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => pickimagefromGallery(context),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(size.width, size.height * 0.06),
                      backgroundColor: coachImage != null
                          ? Pallete.primaryColor
                          : Pallete.greyColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                  child: Text(
                    'Add Coach image',
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
                  onPressed: () => seCoach(ref),
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
