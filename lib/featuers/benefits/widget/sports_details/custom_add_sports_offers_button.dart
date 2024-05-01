import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/common/custom_elevated_button.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/utils.dart';
import '../../../../theme/pallete.dart';

class CustomAddSportsOffersButton extends ConsumerStatefulWidget {
  final String sportsId;
  const CustomAddSportsOffersButton({
    super.key,
    required this.sportsId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomAddSportsOffersButtonState();
}

class _CustomAddSportsOffersButtonState
    extends ConsumerState<CustomAddSportsOffersButton> {
  TextEditingController? title;
  TextEditingController? description;
  TextEditingController? discount;
  File? logo;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  void initState() {
    title = TextEditingController();
    description = TextEditingController();
    discount = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    title!.dispose();
    description!.dispose();
    discount!.dispose();
    super.dispose();
  }

  setSportsOffers() {
    var formvalid = formstate.currentState;
    if (formvalid!.validate() && logo != null) {
      ref.watch(benefitsControllerProvider.notifier).setSportsOffers(
          title!.text,
          description!.text,
          discount!.text,
          widget.sportsId,
          context,
          logo!);
      title!.clear();
      description!.clear();
      discount!.clear();
      logo = null;
      Get.back();
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

    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () => Get.bottomSheet(Container(
        padding: EdgeInsets.all(10),
        height: size.height * 0.7,
        child: Form(
          key: formstate,
          child: ListView(
            children: [
              TextFiled(
                name: "title",
                controller: title!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.width * 0.02,
              ),
              TextFiled(
                name: "Description",
                controller: description!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFiled(
                name: "discount",
                controller: discount!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              logo == null
                  ? Container(
                      height: size.height * 0.14,
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
                  : Container(
                      height: size.height * 0.14,
                      width: size.width * 0.6,
                      child: Image.file(
                        logo!,
                        fit: BoxFit.contain,
                      )),
              SizedBox(
                height: size.width * 0.03,
              ),
              CustomElevatedButton(
                  size: size,
                  color: Color.fromARGB(255, 52, 180, 189),
                  title: "Add offer image",
                  sizeofwidth: size.width * 0.2,
                  sizeofhight: size.width * 0.05,
                  onTap: () => pickimagefromGallery(context)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => setSportsOffers(),
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width * 0.6, size.height * 0.04),
                      backgroundColor: Color.fromARGB(255, 52, 180, 189),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: Pallete.listofGridientCard,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(3.14 / 4)),
        ),
      )),
      child: Row(
        children: [
          Image.asset(
            "assets/page-1/images/kamn_splash.png",
            fit: BoxFit.contain,
          ),
          Text(
            'Add New Plan',
            style: TextStyle(
                color: Pallete.whiteColor,
                fontFamily: "Muller",
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
          fixedSize: Size(size.width * 0.6, size.height * 0.04),
          backgroundColor: Pallete.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width * 0.02))),
    );
  }
}