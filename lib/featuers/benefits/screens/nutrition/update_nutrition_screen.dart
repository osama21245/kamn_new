import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/alex_regions_lists.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/utils.dart';
import '../../../../core/providers/valid.dart';
import '../../../../models/nutrition_model.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';

class UpdateNutrtionScreen extends ConsumerStatefulWidget {
  final NutritionModel nutritionModel;
  const UpdateNutrtionScreen({super.key, required this.nutritionModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateNutrtionScreenState();
}

class _UpdateNutrtionScreenState extends ConsumerState<UpdateNutrtionScreen> {
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
  File? logo;

  @override
  void initState() {
    faceBook = TextEditingController(text: widget.nutritionModel.faceBook);
    instgram = TextEditingController(text: widget.nutritionModel.instgram);
    whatsAppNumber =
        TextEditingController(text: widget.nutritionModel.whatsApp);
    specialization =
        TextEditingController(text: widget.nutritionModel.specialization);
    dynamicLink =
        TextEditingController(text: widget.nutritionModel.dynamicLink);
    fullname = TextEditingController(text: widget.nutritionModel.name);
    discount =
        TextEditingController(text: widget.nutritionModel.discount.toString());
    lat = TextEditingController(text: widget.nutritionModel.lat.toString());
    long = TextEditingController(text: widget.nutritionModel.long.toString());
    about = TextEditingController(text: widget.nutritionModel.about);
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
    super.dispose();
  }

  updateNutrition(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      NutritionModel nutritionModel = NutritionModel(
          id: widget.nutritionModel.id,
          name: fullname!.text,
          userId: widget.nutritionModel.userId,
          image: logo == null ? widget.nutritionModel.image : "",
          specialization: specialization!.text,
          discount: int.parse(discount!.text),
          gallery: widget.nutritionModel.gallery,
          long: double.parse(long!.text),
          lat: double.parse(lat!.text),
          rating: 0,
          about: about!.text,
          city: widget.nutritionModel.city,
          region: region,
          faceBook: faceBook!.text,
          instgram: instgram!.text,
          whatsApp: whatsAppNumber!.text,
          dynamicLink: dynamicLink!.text);
      // may cause Erorr null check because logo!
      ref
          .watch(benefitsControllerProvider.notifier)
          .updateNutrition(nutritionModel, logo, context);
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
                "Finish Nutrition Setup",
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
                "Please complete the following information to \n Fisnsh Your Nutrition Setup",
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
                        validator: (val) {
                          return validinput(val!, 1, 500, "");
                        },
                        name: "Specialization",
                        controller: specialization!,
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
                  ? Image.network(widget.nutritionModel.image)
                  : Image.file(logo!),
              SizedBox(
                height: size.height * 0.023,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => pickimagefromGallery(context),
                  child: Text(
                    'Update Nutrtion image',
                    style: TextStyle(
                        color: Pallete.whiteColor,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(size.width, size.height * 0.06),
                      backgroundColor: logo == null
                          ? Pallete.greyColor
                          : Pallete.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => updateNutrition(ref),
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
