import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/common/custom_elevated_button.dart';
import 'package:kman/featuers/orders/widget/medical/custom_medical_service_orders_section.dart';
import 'package:kman/models/medical_reservision_model.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../../../../core/common/custom_uppersec.dart';
import '../../../../../theme/pallete.dart';
import '../../../../core/common/textfield.dart';
import '../../../../core/providers/valid.dart';
import '../../widget/medical/custom_medical_offer_order_secion.dart';
import '../../controller/orders_controller.dart';

class SureMedicalReservision extends ConsumerStatefulWidget {
  final MedicalReservisionModel medicalReservisionModel;
  const SureMedicalReservision({
    super.key,
    required this.medicalReservisionModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SureMedicalReservisionState();
}

class _SureMedicalReservisionState
    extends ConsumerState<SureMedicalReservision> {
  TextEditingController? price;
  String qrLink = "";
  bool calcPrice = false;
  QRCodeShow(BuildContext context, Size size) async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(
            isShowFlashIcon: true,
          ),
        ));
    if (res is String) {
      if (res == "https://bit.ly/KAMN-كامن-AppsonGooglePlay?r=qr") {
        qrLink = res;
        sureMedicalReservision();
        Get.dialog(
          AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Success'),
                Text(
                  "ID:${widget.medicalReservisionModel.ordersId}",
                  style: TextStyle(fontSize: size.width * 0.016),
                )
              ],
            ),
            content: Text(
                "you have successfully sure your reservation at ${widget.medicalReservisionModel.ordersServiceProviderName}."),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                }, // Close dialog
                child: Text('Close'),
              ),
            ],
          ),
        );
      } else {
        AwesomeDialog(
            dialogBackgroundColor: const Color.fromARGB(255, 231, 230, 230),
            barrierColor: Color.fromARGB(108, 0, 0, 0),
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

  void cancleReservision() {
    ref.watch(ordersControllerProvider.notifier).cancleMedicalReservision(
        widget.medicalReservisionModel.ordersId, context);
  }

  void sureMedicalReservision() {
    ref.watch(ordersControllerProvider.notifier).sureMedicalReservision(
        widget.medicalReservisionModel.ordersId, price!.text, context);
  }

  @override
  void initState() {
    price = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    price!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 5),
                child: CustomUpperSec(
                    size: size,
                    color: Pallete.fontColor,
                    title: "Finish reservision")),
            SizedBox(
              height: size.height * 0.027,
            ),
            CustomMedicalOfferOrdersSection(
              medicalReservisionModel: widget.medicalReservisionModel,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            CustomMedicalServiceOrdersSection(
              medicalReservisionModel: widget.medicalReservisionModel,
            ),

            // if (calcPrice != true)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Column(
                children: [
                  TextFiled(
                    validator: (val) {
                      return validinput(val!, 4, 500, "");
                    },
                    name: "Price",
                    controller: price!,
                    color: Pallete.lightgreyColor2,
                  ),
                  CustomElevatedButton(
                      size: size,
                      color: Pallete.fontColor,
                      title: "Calculate",
                      sizeofwidth: size.width * 0.45,
                      sizeofhight: size.width * 0.02,
                      onTap: () {
                        setState(() {
                          if (price != "") {
                            setState(() {
                              calcPrice = true;
                            });
                          }
                        });
                      }),
                  price!.text.isNum
                      ? Text("Price: ${price!.text}")
                      : price!.text == ""
                          ? Text("Price: ")
                          : Text("Price: Invalid number"),
                  Text(
                      "Discount: ${widget.medicalReservisionModel.orderdiscount}"),
                  price!.text == ""
                      ? Text("FinalPrice: ")
                      : price!.text.isNum
                          ? Text(
                              "FinalPrice: ${int.parse(price!.text) - ((int.parse(widget.medicalReservisionModel.orderdiscount) / 100) * int.parse(price!.text))}")
                          : Text("FinalPrice: 0.0"),
                  CustomElevatedButton(
                      size: size,
                      color: calcPrice == false
                          ? Pallete.greyColor
                          : Pallete.fontColor,
                      title: "Use qr code",
                      sizeofwidth: size.width * 0.78,
                      sizeofhight: size.width * 0.02,
                      onTap: calcPrice == false
                          ? () {}
                          : () => QRCodeShow(context, size)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: ElevatedButton(
                      onPressed: () => cancleReservision(),
                      child: Text(
                        'Delete your order',
                        style: TextStyle(
                            color: Pallete.whiteColor,
                            fontFamily: "Muller",
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width, size.height * 0.04),
                          backgroundColor: Colors.red[400],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
