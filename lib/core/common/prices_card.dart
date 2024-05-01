import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/models/prices_model.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../featuers/payment/screens/toggle_screen.dart';
import '../../models/passorder_model.dart';
import '../../theme/pallete.dart';

class PricesCard extends StatefulWidget {
  PricesModel pricesModel;
  String serviceProviderId;
  PricesCard(
      {super.key, required this.pricesModel, required this.serviceProviderId});

  @override
  State<PricesCard> createState() => _PricesCardState();
}

String QrCode = "";
int? index;

class _PricesCardState extends State<PricesCard> {
  QRCodeShow(context, Size size) async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(
            isShowFlashIcon: true,
          ),
        ));
    if (res is String) {
      if (res == "https://bit.ly/KAMN-كامن-AppsonGooglePlay?r=qr") {
        QrCode = res;
        AwesomeDialog(
            dialogBackgroundColor: const Color.fromARGB(255, 231, 230, 230),
            barrierColor: const Color.fromARGB(108, 255, 255, 255),
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType
                .success, // Use NO_HEADER to remove the default header
            btnOkOnPress: () {},
            body: Column(children: [
              Text(
                'You had 10% discount from Kamn',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Muller",
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600),
              ),
            ]))
          ..show();
      } else {
        AwesomeDialog(
            dialogBackgroundColor: const Color.fromARGB(255, 231, 230, 230),
            barrierColor: const Color.fromARGB(108, 255, 255, 255),
            context: context,
            animType: AnimType.scale,
            dialogType:
                DialogType.error, // Use NO_HEADER to remove the default header
            btnOkOnPress: () {},
            body: Column(children: [
              Text(
                'This Qr is not avaliable',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Muller",
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600),
              ),
            ]))
          ..show();
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.73,
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
                              colors: Pallete.listofGridientCardPrice,
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
                                    if (QrCode == "")
                                      ElevatedButton(
                                        onPressed: () =>
                                            QRCodeShow(context, size),
                                        child: Text(
                                          'USE KAMN DISCOUNT',
                                          style: TextStyle(
                                              color: Pallete.whiteColor,
                                              fontFamily: "Muller",
                                              fontSize: size.width * 0.025,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(size.width * 0.5,
                                                size.height * 0.02),
                                            backgroundColor: Color.fromARGB(
                                                255, 80, 236, 119),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.03))),
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
                                              PassOrderModel passOrderModel = PassOrderModel(storeId: "",
                                                  serviceProviderName: "",
                                                  discount: discount,
                                                  totalPrice: (int.parse(widget.pricesModel.prices[i]) -
                                                              ((discount / 100) *
                                                                  int.parse(
                                                                      widget.pricesModel.prices[
                                                                          i])))
                                                          .toInt() *
                                                      100,
                                                  price: widget
                                                      .pricesModel.prices[i],
                                                  seviceProviderId:
                                                      widget.serviceProviderId,
                                                  ordername: widget
                                                      .pricesModel.planName[i],
                                                  orderDescription: widget
                                                      .pricesModel
                                                      .planDescriptions[i],
                                                  orderplanTime: "0",
                                                  mixOrSeparateOrGroupOrPrivet: "mix");
                                              Get.to(
                                                () => ToggleScreen(
                                                  collection: "doctor",
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
