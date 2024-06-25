import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/featuers/user/controller/user_controller.dart';
import '../../../../../HandlingDataView.dart';
import '../../../../../core/common/textfield.dart';
import '../../../../../core/providers/utils.dart';
import '../../../../../core/providers/valid.dart';
import '../../../../../theme/pallete.dart';

class AddInBoxScreen extends ConsumerStatefulWidget {
  final String serviceProviderId;
  const AddInBoxScreen({super.key, required this.serviceProviderId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddInBoxScreenState();
}

class _AddInBoxScreenState extends ConsumerState<AddInBoxScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? title;
  TextEditingController? description;
  bool isimageSet = false;
  File? inBoxImage;
  @override
  void initState() {
    title = TextEditingController();
    description = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    title!.dispose();
    description!.dispose();
    super.dispose();
  }

  setInbox(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      ref.watch(userControllerProvider.notifier).sendInboxToUser(
          title: title!.text,
          description: description!.text,
          imageFile: inBoxImage,
          userId: widget.serviceProviderId,
          defImage: false,
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
        inBoxImage = File(res.files.first.path!);
        isimageSet = true;
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
                  "Finish Inbox Setup",
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
                  "Please complete the following information to \n Fisnsh Your Inbox Setup",
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
                    return validinput(val!, 4, 38, "");
                  },
                  name: "title",
                  controller: title!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 4, 300, "");
                  },
                  name: "description",
                  controller: description!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                inBoxImage == null || inBoxImage == File("")
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
                          "Enter Image",
                          style: TextStyle(
                              color: Pallete.greyColor,
                              fontFamily: "Muller",
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w600),
                        )))
                    : Image.file(inBoxImage!),
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
                        backgroundColor: inBoxImage != null
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
                    onPressed: () => setInbox(ref),
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
      ),
    );
  }
}
