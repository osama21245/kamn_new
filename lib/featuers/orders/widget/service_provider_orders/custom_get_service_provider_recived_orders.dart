import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/featuers/orders/widget/customcardPending.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common/error_text.dart';
import '../../../../core/common/no_data_animation.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../../theme/pallete.dart';

class CustomGetServiceProviderRecivedOrders extends ConsumerWidget {
  final String storeId;
  const CustomGetServiceProviderRecivedOrders(
      {super.key, required this.storeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.sizeOf(context);
    final userId = ref.watch(usersProvider)!.uid;
    final Tuple2 tuple2 = Tuple2(userId, storeId);
    return ref.watch(getServiceProviderRecivedOrdersProvider(tuple2)).when(
        data: (orders) => orders.isEmpty
            ? NoDataAnimation(size: size)
            : Expanded(
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
