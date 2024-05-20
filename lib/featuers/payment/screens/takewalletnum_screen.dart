// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/common/textfield.dart';
import 'package:kman/core/providers/valid.dart';
import 'package:kman/featuers/payment/controller/payment_controller.dart';
import 'package:kman/models/passorder_model.dart';
import '../../../models/qr_order_model.dart';
import '../../../theme/pallete.dart';

class TakeWalletNumScren extends ConsumerStatefulWidget {
  final int price;
  final PassOrderModel passOrderModel;
  final QrOrderModel qrOrderModel;
  final String collection;
  const TakeWalletNumScren({
    required this.price,
    required this.passOrderModel,
    required this.qrOrderModel,
    required this.collection,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TakeWalletNumScrenState();
}

class _TakeWalletNumScrenState extends ConsumerState<TakeWalletNumScren> {
  TextEditingController? phone;

  @override
  void initState() {
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phone!.dispose();
    super.dispose();
  }

  void gotoMobileWalletPage(WidgetRef ref) {
    ref.watch(paymentControllerProvider.notifier).getidMobileWallet(
        widget.price.toString(),
        phone!.text,
        widget.passOrderModel,
        widget.collection,
        widget.qrOrderModel);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(paymentControllerProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: HandlingDataView(
          statusRequest: statusRequest,
          widget: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
                top: size.width * 0.19,
                bottom: size.width * 0.1),
            child: ListView(
              children: [
                Image.asset(
                  "assets/page-1/images/verification.png",
                  height: size.height * 0.34,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "Verify Your Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Pallete.fontColor,
                      fontFamily: "Muller",
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size.height * 0.014,
                ),
                Text(
                  "Please enter you country \n Your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Pallete.greyColor,
                      fontFamily: "Muller",
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Pallete.lightgreyColor,
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02)),
                      height: size.height * 0.07,
                      width: size.width * 0.12,
                      child: Icon(Icons.arrow_drop_down_rounded),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.1),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                          color: Pallete.lightgreyColor,
                        ),
                        child: TextFiled(
                            color: Pallete.lightgreyColor2,
                            validator: (val) {
                              return validinput(val!, 11, 11, "phone");
                            },
                            name: "",
                            controller: phone!,
                            istakenum: true),
                      ),
                    ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: ElevatedButton(
                    onPressed: () => gotoMobileWalletPage(ref),
                    child: Text(
                      'SEND',
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.77, size.height * 0.06),
                        backgroundColor: Pallete.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02))),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.3,
                )
              ],
            ),
          ),
        ));
  }
}
