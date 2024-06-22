import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/providers/utils.dart';
import 'package:kman/featuers/payment/controller/payment_controller.dart';
import 'package:kman/models/qr_order_model.dart';
import '../../../HandlingDataView.dart';
import '../../../models/passorder_model.dart';
import 'takewalletnum_screen.dart';

class ToggleScreen extends ConsumerStatefulWidget {
  final PassOrderModel passOrderModel;
  final QrOrderModel? qrOrderModel;
  final String collection;
  const ToggleScreen(
      {super.key,
      required this.passOrderModel,
      required this.collection,
      this.qrOrderModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToggleScreenState();
}

kisko(WidgetRef ref, String price) {
  ref.watch(paymentControllerProvider.notifier).getidKiosk(price);
}

class _ToggleScreenState extends ConsumerState<ToggleScreen> {
  gettoken(WidgetRef ref) {
    ref.watch(paymentControllerProvider.notifier).gettoken();
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      gettoken(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getId(WidgetRef ref, String price) {
      ref.watch(paymentControllerProvider.notifier).getid(widget.passOrderModel,
          widget.qrOrderModel ?? qrOrderCommanModel, widget.collection);
    }

    valuPayment(WidgetRef ref, String price) {
      ref
          .watch(paymentControllerProvider.notifier)
          .geValutid(widget.passOrderModel, widget.collection);
    }

    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(paymentControllerProvider);
    return SafeArea(
      child: Scaffold(
          body: HandlingDataView(
        statusRequest: statusRequest,
        widget: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Expanded(
              //   child: InkWell(
              //     onTap: () {
              //       valuPayment(ref, widget.passOrderModel.price.toString());
              //     },
              //     child: Container(
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         color: Colors.black12,
              //         borderRadius: BorderRadius.circular(15.0),
              //         border: Border.all(color: Colors.black87, width: 2.0),
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.all(size.width * 0.1),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: size.width * 0.12,
              //                   vertical: size.width * 0.04),
              //               child: Image(
              //                 image:
              //                     AssetImage("assets/page-1/images/wallet.png"),
              //               ),
              //             ),
              //             SizedBox(height: 15.0),
              //             Text(
              //               'Payment with valu',
              //               style: TextStyle(
              //                 fontSize: 20.0,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20.0),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(TakeWalletNumScren(
                      qrOrderModel: widget.qrOrderModel ?? qrOrderCommanModel,
                      collection: widget.collection,
                      passOrderModel: widget.passOrderModel,
                      price: widget.passOrderModel.totalPrice,
                    ));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black87, width: 2.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.12,
                                vertical: size.width * 0.04),
                            child: Image(
                              image:
                                  AssetImage("assets/page-1/images/wallet.png"),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Mobile wallet',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: InkWell(
                  onTap: () {
                    getId(ref, widget.passOrderModel.totalPrice.toString());
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black, width: 2.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.12,
                                vertical: size.width * 0.04),
                            child: Image(
                              image:
                                  AssetImage("assets/page-1/images/visa.png"),
                            ),
                          ),
                          Text(
                            'Visa',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      )),
    );
  }
}
