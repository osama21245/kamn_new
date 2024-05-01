import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/featuers/orders/widget/customcardPending.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';

class CustomGetServiceProviderRecivedOrders extends ConsumerWidget {
  const CustomGetServiceProviderRecivedOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final userId = ref.watch(usersProvider)!.uid;
    return ref.watch(getServiceProviderRecivedOrdersProvider(userId)).when(
        data: (orders) => Expanded(
              child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, i) {
                    final order = orders[i];
                    return InkWell(
                        onTap: () {},
                        child: CustomcardPending(
                          orderModel: order,
                          size: size,
                          fromserviceProviderScreen: true,
                        ));
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
