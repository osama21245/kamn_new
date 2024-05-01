import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:kman/core/function/checkAuth.dart';
import 'package:kman/models/coach_prices_model.dart';
import 'package:kman/models/passorder_model.dart';
import '../../../../core/common/textfield.dart';
import '../../../../models/user_model.dart';
import '../../../../theme/pallete.dart';
import '../../controller/coaches-gyms_controller.dart';

class CoachPricesCard extends ConsumerStatefulWidget {
  CoachPricesModel pricesModel;
  String coachName;
  String coachId;
  String serviceProviderId;
  UserModel usermodel;
  String collection;
  CoachPricesCard(
      {super.key,
      required this.pricesModel,
      required this.serviceProviderId,
      required this.coachId,
      required this.collection,
      required this.usermodel,
      required this.coachName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CoachPricesCardState();
}

class _CoachPricesCardState extends ConsumerState<CoachPricesCard> {
  TextEditingController? price;
  TextEditingController? plan;
  TextEditingController? description;
  TextEditingController? planTime;
  TextEditingController? textFieldDiscount;
  TextEditingController? points;
  String gym = "Privet";

  @override
  void initState() {
    price = TextEditingController();
    plan = TextEditingController();
    description = TextEditingController();
    textFieldDiscount = TextEditingController();
    points = TextEditingController();
    planTime = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    price!.dispose();
    plan!.dispose();
    description!.dispose();
    textFieldDiscount!.dispose();
    points!.dispose();
    planTime!.dispose();
    super.dispose();
  }

  String QrCode = "";
  int? index;

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

  @override
  Widget build(BuildContext context) {
    List<String> gymList = [
      'Privet',
      'Group',
    ];

    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.65,
      child: ListView.builder(
          itemCount: widget.pricesModel.planName.length,
          itemBuilder: (context, i) {
            int discount = int.parse(widget.pricesModel.discount[i]);
            if (QrCode != "") {
              discount = discount + 10;
            }
            return InkWell(
                onLongPress: () {
                  widget.pricesModel.planDescriptions
                      .delete(widget.pricesModel.planDescriptions[i]);
                  widget.pricesModel.planName
                      .delete(widget.pricesModel.planName[i]);
                  widget.pricesModel.prices
                      .delete(widget.pricesModel.prices[i]);
                  widget.pricesModel.discount
                      .delete(widget.pricesModel.discount[i]);
                  widget.pricesModel.points
                      .delete(widget.pricesModel.points[i]);
                  widget.pricesModel.isGroup
                      .delete(widget.pricesModel.isGroup[i]);
                  widget.pricesModel.reservisionTimes
                      .delete(widget.pricesModel.reservisionTimes[i]);
                  updatePricesBenefits(
                      widget.pricesModel.prices,
                      widget.pricesModel.planName,
                      widget.pricesModel.planDescriptions,
                      widget.pricesModel.discount,
                      widget.pricesModel.points,
                      widget.pricesModel.isGroup,
                      widget.pricesModel.reservisionTimes);
                  price!.clear();
                  plan!.clear();
                  description!.clear();
                  textFieldDiscount!.clear();
                  points!.clear();
                  planTime!.clear();
                  Get.back();
                },
                onDoubleTap: () {
                  description!.text = widget.pricesModel.planDescriptions[i];
                  plan!.text = widget.pricesModel.planName[i];
                  price!.text = widget.pricesModel.prices[i];
                  textFieldDiscount!.text = widget.pricesModel.discount[i];
                  points!.text = widget.pricesModel.points[i];
                  gym = widget.pricesModel.isGroup[i];
                  planTime!.text = widget.pricesModel.reservisionTimes[i];
                  Get.bottomSheet(Container(
                    padding: EdgeInsets.all(10),
                    height: size.height * 0.48,
                    child: ListView(
                      children: [
                        TextFiled(
                          name: "Plan",
                          controller: plan!,
                          color: Pallete.lightgreyColor2,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
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
                          name: "Points",
                          controller: points!,
                          color: Pallete.lightgreyColor2,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        TextFiled(
                          name: "price",
                          controller: price!,
                          color: Pallete.lightgreyColor2,
                        ),
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        TextFiled(
                          name: "discount",
                          controller: textFieldDiscount!,
                          color: Pallete.lightgreyColor2,
                        ),
                        SizedBox(
                          height: size.width * 0.03,
                        ),
                        TextFiled(
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
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05),
                            child: DropdownButton(
                              underline: Text(""),
                              style: TextStyle(
                                  color: Pallete.lightgreyColor2,
                                  fontFamily: "Muller",
                                  fontSize: size.width * 0.037,
                                  fontWeight: FontWeight.w500),
                              isExpanded: true,
                              value: gym,
                              focusColor:
                                  const Color.fromARGB(0, 255, 192, 192),
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
                            onPressed: () {
                              widget.pricesModel.planDescriptions[i] =
                                  description!.text;
                              widget.pricesModel.planName[i] = plan!.text;
                              widget.pricesModel.prices[i] = price!.text;
                              widget.pricesModel.discount[i] =
                                  textFieldDiscount!.text;
                              widget.pricesModel.points[i] = points!.text;
                              widget.pricesModel.isGroup[i] = gym;
                              widget.pricesModel.reservisionTimes[i] =
                                  planTime!.text;
                              updatePricesBenefits(
                                  widget.pricesModel.prices,
                                  widget.pricesModel.planName,
                                  widget.pricesModel.planDescriptions,
                                  widget.pricesModel.discount,
                                  widget.pricesModel.points,
                                  widget.pricesModel.isGroup,
                                  widget.pricesModel.reservisionTimes);
                              price!.clear();
                              plan!.clear();
                              description!.clear();
                              textFieldDiscount!.clear();
                              points!.clear();
                              planTime!.clear();
                              Get.back();
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontFamily: "Muller",
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(size.width * 0.6, size.height * 0.04),
                                backgroundColor:
                                    Color.fromARGB(255, 52, 180, 189),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02))),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: Pallete.listofGridientCard,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          transform: GradientRotation(3.14 / 4)),
                    ),
                  ));
                },
                onTap: () {
                  if (index != null) {
                    index = null;
                  } else {
                    index = i;
                    setState(() {});
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.width * 0.012),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                          gradient: LinearGradient(
                              colors: Pallete.listofGridientCardGymPrices,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              transform: GradientRotation(3.14 / 4)),
                        ),
                        child: ListTile(
                          title: Text("${widget.pricesModel.planName[i]}"),
                          subtitle: index != i
                              ? Text(
                                  "${widget.pricesModel.planDescriptions[i]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        widget.pricesModel.isGroup[i] == "Group"
                                            ? Text(
                                                "Group",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        size.width * 0.046),
                                                textAlign: TextAlign.start,
                                              )
                                            : Text(
                                                "Privet",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        size.width * 0.046),
                                                textAlign: TextAlign.start,
                                              ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.007,
                                    ),
                                    Text(
                                      "${widget.pricesModel.planDescriptions[i]}",
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Times",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${widget.pricesModel.reservisionTimes[i]}",
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02),
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(size.width * 0.03),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                size.width * 0.02),
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Price:",
                                                  style: TextStyle(
                                                    fontFamily: "Muller",
                                                    color: Color.fromARGB(
                                                        255, 250, 220, 52),
                                                    fontSize:
                                                        size.width * 0.037,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "${widget.pricesModel.prices[i]} EGB/Month",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: "Muller",
                                                    color: Pallete.whiteColor,
                                                    fontSize: size.width * 0.04,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.006,
                                            ),
                                            if (QrCode != "")
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Kamn-Discount:",
                                                    style: TextStyle(
                                                      fontFamily: "Muller",
                                                      color: Color.fromARGB(
                                                          255, 75, 250, 52),
                                                      fontSize:
                                                          size.width * 0.037,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "10%",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontFamily: "Muller",
                                                      color: Pallete.whiteColor,
                                                      fontSize:
                                                          size.width * 0.04,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            SizedBox(
                                              height: size.height * 0.006,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Discount:",
                                                  style: TextStyle(
                                                    fontFamily: "Muller",
                                                    color: Color.fromARGB(
                                                        255, 250, 220, 52),
                                                    fontSize:
                                                        size.width * 0.037,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "${widget.pricesModel.discount[i]}%",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: "Muller",
                                                    color: Pallete.whiteColor,
                                                    fontSize: size.width * 0.04,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.006,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "KAMN Points:",
                                                  style: TextStyle(
                                                    fontFamily: "Muller",
                                                    color: Color.fromARGB(
                                                        255, 250, 220, 52),
                                                    fontSize:
                                                        size.width * 0.037,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.width * 0.02,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "+${widget.pricesModel.points[i]}",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontFamily: "Muller",
                                                        color:
                                                            Pallete.whiteColor,
                                                        fontSize:
                                                            size.width * 0.04,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      "assets/page-1/images/coin1.png",
                                                      width: size.width * 0.03,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.006,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Final Price:",
                                                  style: TextStyle(
                                                    fontFamily: "Muller",
                                                    color: Color.fromARGB(
                                                        255, 250, 220, 52),
                                                    fontSize:
                                                        size.width * 0.037,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.width * 0.02,
                                                ),
                                                Text(
                                                  "${int.parse(widget.pricesModel.prices[i]) - ((discount / 100) * int.parse(widget.pricesModel.prices[i]))} EGB/Month",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: "Muller",
                                                    color: Pallete.whiteColor,
                                                    fontSize: size.width * 0.04,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Book Now For ',
                                            style: TextStyle(
                                                color: Pallete.whiteColor,
                                                fontFamily: "Muller",
                                                fontSize: size.width * 0.03,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              PassOrderModel passOrderModel = PassOrderModel(
                                                  storeId: widget.coachId,
                                                  serviceProviderName:
                                                      widget.coachName,
                                                  discount: discount,
                                                  totalPrice: (int.parse(widget.pricesModel.prices[i]) - ((discount / 100) * int.parse(widget.pricesModel.prices[i])))
                                                          .toInt() *
                                                      100,
                                                  price: int.parse(widget
                                                      .pricesModel.prices[i]),
                                                  seviceProviderId:
                                                      widget.serviceProviderId,
                                                  ordername: widget
                                                      .pricesModel.planName[i],
                                                  orderDescription: widget
                                                      .pricesModel
                                                      .planDescriptions[i],
                                                  orderplanTime: widget
                                                      .pricesModel
                                                      .reservisionTimes[i],
                                                  mixOrSeparateOrGroupOrPrivet:
                                                      widget.pricesModel.isGroup[i]);
                                              checkAuth(
                                                  passOrderModel,
                                                  widget.collection,
                                                  context,
                                                  widget.usermodel
                                                      .isAuthanticated,
                                                  size);
                                            },
                                            child: Text(
                                              ' ${int.parse(widget.pricesModel.prices[i]) - ((discount / 100) * int.parse(widget.pricesModel.prices[i]))} EGP/Month',
                                              style: TextStyle(
                                                  color: Pallete.whiteColor,
                                                  fontFamily: "Muller",
                                                  fontSize: size.width * 0.025,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(
                                                    size.width * 0.33,
                                                    size.height * 0.02),
                                                backgroundColor: Color.fromARGB(
                                                    255, 80, 200, 236),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            size.width *
                                                                0.08))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          trailing: index != i
                              ? Icon(Icons.arrow_right)
                              : Icon(Icons.arrow_drop_down_rounded),
                        ),
                      ),
                      Positioned(
                          right: size.width * 0.09,
                          top: size.width * 0.01,
                          child: widget.pricesModel.isGroup[i] == "Group"
                              ? Image.asset(
                                  "assets/page-1/images/group.png",
                                  width: size.width * 0.1,
                                )
                              : Image.asset(
                                  "assets/page-1/images/kamn_sentence_white.png",
                                  width: size.width * 0.1,
                                )),
                    ],
                  ),
                ));
          }),
    );
  }
}
