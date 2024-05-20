import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/models/coach_prices_model.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/valid.dart';
import '../../../../theme/pallete.dart';

class CustomAddCoachPlansButton extends ConsumerStatefulWidget {
  CoachPricesModel coachPricesModel;
  String collection;
  String coachId;
  CustomAddCoachPlansButton({
    super.key,
    required this.coachPricesModel,
    required this.collection,
    required this.coachId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomAddCoachPlansButtonState();
}

class _CustomAddCoachPlansButtonState
    extends ConsumerState<CustomAddCoachPlansButton> {
  TextEditingController? price;
  TextEditingController? plan;
  TextEditingController? description;
  TextEditingController? planTime;
  TextEditingController? discount;
  TextEditingController? points;
  String gym = "Privet";
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  void initState() {
    price = TextEditingController();
    plan = TextEditingController();
    description = TextEditingController();
    discount = TextEditingController();
    points = TextEditingController();
    planTime = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    price!.dispose();
    plan!.dispose();
    description!.dispose();
    discount!.dispose();
    points!.dispose();
    planTime!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updatePricesBenefits(
        List<dynamic> prices,
        List<dynamic> pricePlan,
        List<dynamic> descriptionPlan,
        List<dynamic> discount,
        List<dynamic> points,
        List<dynamic> ismix,
        List<dynamic> planTime) {
      ref.watch(coachesGymsControllerProvider.notifier).updatePricesCoach(
          widget.collection,
          widget.coachId,
          prices,
          pricePlan,
          points,
          descriptionPlan,
          discount,
          ismix,
          planTime,
          context);
    }

    void addPlan() {
      if (formstate.currentState!.validate()) {
        widget.coachPricesModel.planDescriptions.add(description!.text);
        widget.coachPricesModel.planName.add(plan!.text);
        widget.coachPricesModel.prices.add(price!.text);
        widget.coachPricesModel.discount.add(discount!.text);
        widget.coachPricesModel.points.add(points!.text);
        widget.coachPricesModel.isGroup.add(gym);
        widget.coachPricesModel.reservisionTimes.add(planTime!.text);
        updatePricesBenefits(
            widget.coachPricesModel.prices,
            widget.coachPricesModel.planName,
            widget.coachPricesModel.planDescriptions,
            widget.coachPricesModel.discount,
            widget.coachPricesModel.points,
            widget.coachPricesModel.isGroup,
            widget.coachPricesModel.reservisionTimes);
        price!.clear();
        plan!.clear();
        description!.clear();
        discount!.clear();
        points!.clear();
        planTime!.clear();
        Get.back();
      }
    }

    List<String> gymList = [
      'Privet',
      'Group',
    ];

    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () => Get.bottomSheet(Form(
        key: formstate,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: size.height * 0.48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: Pallete.listofGridientCard,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: const GradientRotation(3.14 / 4)),
          ),
          child: ListView(
            children: [
              TextFiled(
                validator: (val) {
                  return validinput(val!, 1, 500, "");
                },
                name: "Plan",
                controller: plan!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextFiled(
                validator: (val) {
                  return validinput(val!, 1, 500, "");
                },
                name: "Description",
                controller: description!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFiled(
                validator: (val) {
                  return validinput(val!, 1, 500, "int");
                },
                name: "Points",
                controller: points!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFiled(
                validator: (val) {
                  return validinput(val!, 1, 500, "int");
                },
                name: "price",
                controller: price!,
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
                  return validinput(val!, 1, 500, "");
                },
                name: "PlanTime",
                controller: planTime!,
                color: Pallete.lightgreyColor2,
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Pallete.fontColor),
                    borderRadius: BorderRadius.circular(size.width * 0.02)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: DropdownButton(
                    underline: const Text(""),
                    style: TextStyle(
                        color: Pallete.lightgreyColor2,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.037,
                        fontWeight: FontWeight.w500),
                    isExpanded: true,
                    value: gym,
                    focusColor: const Color.fromARGB(0, 255, 192, 192),
                    items: gymList.map((gen) {
                      return DropdownMenuItem(
                        value: gen,
                        child: Text(gen),
                        onTap: () {
                          if (gen == gymList[0]) {
                            gym = gymList[0];
                          } else if (gen == gymList[1]) {
                            gym = gymList[1];
                          }
                          setState(() {});
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        gym = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => addPlan(),
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
      )),
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
      ),
    );
  }
}
