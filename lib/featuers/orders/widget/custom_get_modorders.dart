import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/featuers/orders/screens/ordersdetails.dart';
import 'package:kman/featuers/orders/widget/customcardPending.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';

class CustomGetModOrders extends ConsumerWidget {
  String serviceProviderOrUserId;
  CustomGetModOrders({super.key, required this.serviceProviderOrUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return ref.watch(getModOrdersProvider(serviceProviderOrUserId)).when(
        data: (orders) => Expanded(
              child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, i) {
                    final order = orders[i];
                    return CustomcardPending(
                      orderModel: order,
                      size: size,
                      fromserviceProviderScreen: true,
                    );
                  }),
            ),
        error: (error, StackTrace) {
          print(error);

          return ErrorText(error: error.toString());
        },
        loading: () => LottieBuilder.asset(
              fit: BoxFit.contain,
              AppImageAsset.loading,
              repeat: true,
            ));
  }
}
