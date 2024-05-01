import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/featuers/orders/widget/nutrition/custom_card_Pending_nutrition.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/common/error_text.dart';
import '../../../../../core/constants/imgaeasset.dart';
import '../../screens/my_reservisions/orders_nutrition_details.dart';
import '../../screens/my_reservisions/orders_sports_details.dart';
import '../sports/custom_card_Pending_sports.dart';

class CustomGetServiceProviderNutritionReservisions extends ConsumerWidget {
  CustomGetServiceProviderNutritionReservisions({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider);
    return ref
        .watch(getServiceProviderNutritionQrOrdersProvider(user!.uid))
        .when(
            data: (orders) => Expanded(
                  child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, i) {
                        final order = orders[i];
                        return InkWell(
                            onTap: () =>
                                Get.to(() => OrderNutritionDetailsScreen(
                                      fromserviceProviderScreen: true,
                                      qrorderModel: order,
                                    )),
                            child: CustomcardPendingNutrition(
                              qrorderModel: order,
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
