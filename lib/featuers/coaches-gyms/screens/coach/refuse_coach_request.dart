import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/providers/valid.dart';
import 'package:kman/models/coache_model.dart';

import '../../../../HandlingDataView.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/utils.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';
import '../../../user/controller/user_controller.dart';
import '../../controller/coaches-gyms_controller.dart';

class RefuseCoachRequestScreen extends ConsumerStatefulWidget {
  final CoacheModel coacheModel;
  const RefuseCoachRequestScreen({super.key, required this.coacheModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RefuseCoachRequestScreenState();
}

class _RefuseCoachRequestScreenState
    extends ConsumerState<RefuseCoachRequestScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? reson;
  File? attachImage;
  @override
  void initState() {
    reson = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  refuseCoach() {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      ref
          .watch(coachesGymsControllerProvider.notifier)
          .deleteCoachRequest(widget.coacheModel!.id, context);

      ref.watch(userControllerProvider.notifier).sendInboxToUser(
          title: "Soory",
          description: reson!.text,
          imageFile: attachImage,
          userId: widget.coacheModel.userId,
          defImage: attachImage != null ? false : true,
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(coachesGymsControllerProvider);

    pickimagefromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        attachImage = File(res.files.first.path!);
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
          child: ListView(children: [
            Text(
              "Finish Coach Refuse",
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
              "Please complete the following information to \n Fisnsh Your Coach Refuse",
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
                    name: "",
                    controller: reson!,
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
                  SizedBox(
                    height: size.height * 0.023,
                  ),
                  attachImage == null
                      ? Container(
                          height: size.height * 0.15,
                          width: size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Pallete.greyColor, width: 2),
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02)),
                          child: Center(
                              child: Text(
                            "Enter Images",
                            style: TextStyle(
                                color: Pallete.greyColor,
                                fontFamily: "Muller",
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w600),
                          )))
                      : Image.file(attachImage!),
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
                          backgroundColor: attachImage != null
                              ? Pallete.primaryColor
                              : Pallete.greyColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02))),
                      child: Text(
                        'Add image',
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
                      onPressed: () => refuseCoach(),
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          fixedSize: Size(size.width, size.height * 0.06),
                          backgroundColor: Pallete.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02))),
                      child: Text(
                        'Submit',
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
          ])),
    )));
  }
}
