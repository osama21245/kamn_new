import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/models/passorder_model.dart';
import 'package:kman/models/prices_model.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../../models/prices_model copy.dart';
import '../../../../theme/pallete.dart';
import '../../../payment/screens/toggle_screen.dart';

class GymPricesCard extends StatefulWidget {
  GymPricesModel pricesModel;
  String serviceProviderId;
  String gymId;
  String gymName;
  GymPricesCard(
      {super.key,
      required this.pricesModel,
      required this.serviceProviderId,
      required this.gymId,
      required this.gymName});

  @override
  State<GymPricesCard> createState() => _GymPricesCardState();
}

String QrCode = "";
int? index;

class _GymPricesCardState extends State<GymPricesCard> {
  @override
  Widget build(BuildContext context) {
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
                                    Text(
                                      "${widget.pricesModel.planDescriptions[i]}",
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
                                                  "Duration:",
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
                                                  "${widget.pricesModel.planTime[i]} Months",
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
                                                  storeId: widget.gymId,
                                                  serviceProviderName:
                                                      widget.gymName,
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
                                                      .pricesModel.planTime[i],
                                                  mixOrSeparateOrGroupOrPrivet:
                                                      widget.pricesModel.ismix[i]);
                                              Get.to(
                                                () => ToggleScreen(
                                                  collection: "gym",
                                                  passOrderModel:
                                                      passOrderModel,
                                                ),
                                              );
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
                          child: Image.asset(
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
