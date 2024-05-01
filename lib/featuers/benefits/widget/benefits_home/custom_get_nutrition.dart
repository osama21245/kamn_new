import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/services/collection_constants.dart';
import 'package:kman/featuers/benefits/screens/nutrition/nutrition_details_screen.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_nutrition_card.dart';

import 'package:kman/models/nutrition_model.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../orders/screens/orders_screen.dart';
import '../../controller/benefits_controller.dart';

class CustomGetNutrition extends ConsumerWidget {
  final bool fromOrders;
  final String region;
  const CustomGetNutrition(
      {super.key, required this.fromOrders, required this.region});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NutritionModel> filterList;
    return ref.watch(getNutritionProvider).when(
        data: (nutritions) {
          filterList = nutritions
              .where((element) => element.region.contains(region))
              .toList();
          return region == "All"
              ? Expanded(
                  child: ListView.builder(
                      itemCount: nutritions.length,
                      itemBuilder: (context, i) {
                        final nutrition = nutritions[i];
                        return InkWell(
                            onTap: () => Get.to(() => fromOrders
                                ? OrdersScreen(
                                    serviceProviderOrUserId: nutrition.userId)
                                : NutritionDetailsScreen(
                                    fromAsk: false,
                                    nutritionModel: nutrition,
                                    collection: Collections.nutritionCollection,
                                  )),
                            child: CustomNutritionCard(
                              nutritionModel: nutrition,
                            ));
                      }),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: filterList.length,
                      itemBuilder: (context, i) {
                        final nutrition = filterList[i];
                        return InkWell(
                            onTap: () => Get.to(() => fromOrders
                                ? OrdersScreen(
                                    serviceProviderOrUserId: nutrition.userId)
                                : NutritionDetailsScreen(
                                    fromAsk: false,
                                    nutritionModel: nutrition,
                                    collection: Collections.nutritionCollection,
                                  )),
                            child: CustomNutritionCard(
                              nutritionModel: nutrition,
                            ));
                      }),
                );
        },
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
