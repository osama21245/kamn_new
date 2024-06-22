import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/common/error_text.dart';
import '../../../../../core/constants/imgaeasset.dart';
import '../../../../core/common/no_data_animation.dart';
import '../../screens/my_reservisions/orders_sports_details.dart';
import '../nutrition/custom_card_Pending_nutrition.dart';
import '../sports/custom_card_Pending_sports.dart';

class CustomGetUserNutritionReservisions extends ConsumerWidget {
  CustomGetUserNutritionReservisions({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.sizeOf(context);
    final user = ref.watch(usersProvider);
    return ref.watch(getNutritionQrOrdersProvider(user!.uid)).when(
        data: (orders) => orders.isEmpty
            ? NoDataAnimation(
                size: size,
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, i) {
                      final order = orders[i];
                      return InkWell(
                          onTap: () => Get.to(() => OrderSportsDetailsScreen(
                                fromserviceProviderScreen: false,
                                qrorderModel: order,
                              )),
                          child: CustomcardPendingNutrition(
                            qrorderModel: order,
                            size: size,
                            fromserviceProviderScreen: false,
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
