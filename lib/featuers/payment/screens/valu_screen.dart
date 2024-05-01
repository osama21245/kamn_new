import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/models/passorder_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/payment_controller.dart';

class ValuScreen extends ConsumerStatefulWidget {
  String url;
  String collection;
  PassOrderModel passOrderModel;
  ValuScreen(
      {super.key,
      required this.url,
      required this.passOrderModel,
      required this.collection});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ValuScreenState();
}

class _ValuScreenState extends ConsumerState<ValuScreen> {
  setorder(BuildContext context) async {
    // bool isSecure =
    //     await ref.watch(paymentControllerProvider.notifier).callBack();

    //  if (isSecure == true) {
    if (widget.collection != "medical") {
      ref.watch(ordersControllerProvider.notifier).setOrder(
          context,
          widget.passOrderModel.discount,
          widget.passOrderModel.totalPrice,
          "Valu",
          widget.passOrderModel.seviceProviderId,
          widget.passOrderModel.serviceProviderName,
          widget.passOrderModel.price,
          widget.passOrderModel.ordername,
          widget.passOrderModel.orderDescription,
          widget.passOrderModel.mixOrSeparateOrGroupOrPrivet,
          widget.collection,
          widget.passOrderModel.storeId,
          widget.passOrderModel.orderplanTime);
    } else {
      ref.watch(ordersControllerProvider.notifier).setMedicalReservision(
          widget.passOrderModel.ordername,
          widget.passOrderModel.discount.toString(),
          widget.passOrderModel.orderDescription,
          widget.passOrderModel.orderplanTime,
          "Valu",
          widget.passOrderModel.seviceProviderId,
          widget.passOrderModel.serviceProviderName,
          "",
          widget.passOrderModel.mixOrSeparateOrGroupOrPrivet,
          '',
          0,
          widget.passOrderModel.storeId,
          context);
    }
    //}
  }

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (url.contains('success=false')) {
              print(
                  "=========================================================osama notttttttttttttt=========================================");
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('success=true')) {
              setorder(context);
              widget.url = request.url;
              print(
                  "=========================================================osama =========================================");
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Check'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
