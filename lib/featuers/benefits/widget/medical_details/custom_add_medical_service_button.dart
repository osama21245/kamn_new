import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import '../../../../core/common/textfield.dart';
import '../../../../theme/pallete.dart';

class CustomAddMedicalOffersButton extends ConsumerStatefulWidget {
  final String medicalId;
  const CustomAddMedicalOffersButton({
    super.key,
    required this.medicalId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomAddMedicalOffersButtonState();
}

class _CustomAddMedicalOffersButtonState
    extends ConsumerState<CustomAddMedicalOffersButton> {
  TextEditingController? title;
  TextEditingController? description;
  TextEditingController? discount;
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

  setMedicalService() {
    var formvalid = formstate.currentState;
    if (formvalid!.validate()) {
      ref.watch(benefitsControllerProvider.notifier).setMedicalServices(
            widget.medicalId,
            title!.text,
            description!.text,
            discount!.text,
            context,
          );
      title!.clear();
      description!.clear();
      discount!.clear();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => setMedicalService(),
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
