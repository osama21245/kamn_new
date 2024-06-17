import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/models/sports_model.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/alex_regions_lists.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/utils.dart';
import '../../../../core/providers/valid.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';

class UpdateSportsScreen extends ConsumerStatefulWidget {
  final SportsModel sportsModel;
  const UpdateSportsScreen({super.key, required this.sportsModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateSportsScreenState();
}

class _UpdateSportsScreenState extends ConsumerState<UpdateSportsScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String region = "Miami";
  TextEditingController? fullname;
  TextEditingController? faceBook;
  TextEditingController? instgram;
  TextEditingController? whatsAppNumber;
  TextEditingController? dynamicLink;
  TextEditingController? discount;
  TextEditingController? lat;
  TextEditingController? long;
  TextEditingController? about;
  File logo = File("");
  bool isPhotoUpdated = false;

  @override
  void initState() {
    faceBook = TextEditingController(text: widget.sportsModel.faceBook);
    instgram = TextEditingController(text: widget.sportsModel.instgram);
    whatsAppNumber = TextEditingController(text: widget.sportsModel.whatsApp);
    dynamicLink = TextEditingController(text: widget.sportsModel.dynamicLink);
    fullname = TextEditingController(text: widget.sportsModel.name);
    discount =
        TextEditingController(text: widget.sportsModel.discount.toString());
    lat = TextEditingController(text: widget.sportsModel.lat.toString());
    long = TextEditingController(text: widget.sportsModel.long.toString());
    about = TextEditingController(text: widget.sportsModel.about);
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
    lat!.dispose();
    long!.dispose();
    about!.dispose();
    super.dispose();
  }

  updateNutrition(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      SportsModel sportsModel = SportsModel(
          id: widget.sportsModel.id,
          name: fullname!.text,
          servicePrividerId: widget.sportsModel.servicePrividerId,
          image: widget.sportsModel.image,
          discount: int.parse(discount!.text),
          gallery: widget.sportsModel.gallery,
          long: double.parse(long!.text),
          lat: double.parse(lat!.text),
          rating: 0,
          about: about!.text,
          city: widget.sportsModel.city,
          region: region,
          faceBook: faceBook!.text,
          instgram: instgram!.text,
          whatsApp: whatsAppNumber!.text,
          dynamicLink: dynamicLink!.text);
      // may cause Erorr null check because logo!
      ref
          .watch(benefitsControllerProvider.notifier)
          .updateSports(sportsModel, logo, isPhotoUpdated, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    pickimagefromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        logo = File(res.files.first.path!);
        isPhotoUpdated = true;
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
              SizedBox(
                height: size.height * 0.023,
              ),
              isPhotoUpdated == false
                  ? Image.network(widget.sportsModel.image)
                  : Image.file(logo),
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
                      backgroundColor: Pallete.primaryColor,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ElevatedButton(
                  onPressed: () => updateNutrition(ref),
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
