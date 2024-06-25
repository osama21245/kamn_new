import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/common/custom_elevated_button.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/utils.dart';
import '../../../../core/providers/valid.dart';
import '../../../../theme/pallete.dart';

class CustomAddSportsOffersItemsButton extends ConsumerStatefulWidget {
  final String sportsId;
  const CustomAddSportsOffersItemsButton({
    super.key,
    required this.sportsId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomAddSportsOffersItemsButtonState();
}

class _CustomAddSportsOffersItemsButtonState
    extends ConsumerState<CustomAddSportsOffersItemsButton> {
  TextEditingController? title;
  TextEditingController? prices;
  TextEditingController? discount;
  GlobalKey<FormState>? formKey;
  File? logo;

  @override
  void initState() {
    title = TextEditingController();
    discount = TextEditingController();
    prices = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    title!.dispose();
    discount!.dispose();
    prices!.dispose();
    super.dispose();
  }

  setSportsOffers() {
    var formvalid = formKey!.currentState;
    if (logo != null) {
      if (formvalid!.validate()) {
        ref.watch(benefitsControllerProvider.notifier).setSportsOffersItems(
            title!.text,
            discount!.text,
            prices!.text,
            widget.sportsId,
            context,
            logo!);
        title!.clear();
        discount!.clear();
        prices!.clear();
        logo = null;
        Get.back();
      }
    } else {
      Get.back();

      showSnackBar("You have to add a photo", context);
    }
  }

  pickimagefromGallery(BuildContext context, Size size) async {
    final res = await picImage();

    if (res != null) {
      logo = File(res.files.first.path!);
      Get.back();
      formKey = GlobalKey<FormState>();
      openBottomSheet(size);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        onPressed: () => openBottomSheet(size),
        style: ElevatedButton.styleFrom(
            fixedSize: Size(size.width * 0.6, size.height * 0.04),
            backgroundColor: Pallete.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.02))),
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
        ));
  }

  void openBottomSheet(Size size) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(10),
      height: size.height * 0.7,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: Pallete.listofGridientCard,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: const GradientRotation(3.14 / 4)),
      ),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFiled(
              validator: (val) {
                return validinput(val!, 1, 500, "");
              },
              name: "title",
              controller: title!,
              color: Pallete.lightgreyColor2,
            ),
            SizedBox(
              height: size.width * 0.02,
            ),
            TextFiled(
              validator: (val) {
                return validinput(val!, 1, 500, "int");
              },
              name: "discount",
              controller: discount!,
              color: Pallete.lightgreyColor2,
            ),
            SizedBox(
              height: size.width * 0.03,
            ),
            TextFiled(
              validator: (val) {
                return validinput(val!, 1, 500, "int");
              },
              name: "prices",
              controller: prices!,
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
                        border: Border.all(color: Pallete.greyColor, width: 2),
                        borderRadius: BorderRadius.circular(size.width * 0.02)),
                    child: Center(
                        child: Text(
                      "Enter Offer Image",
                      style: TextStyle(
                          color: Pallete.greyColor,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600),
                    )))
                : SizedBox(
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
                color: const Color.fromARGB(255, 52, 180, 189),
                title: "Add offer image",
                sizeofwidth: size.width * 0.2,
                sizeofhight: size.width * 0.05,
                onTap: () => pickimagefromGallery(context, size)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => setSportsOffers(),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.6, size.height * 0.04),
                    backgroundColor: const Color.fromARGB(255, 52, 180, 189),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(size.width * 0.02))),
                child: Text(
                  'Add',
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
    ));
  }
}
