import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/screens/nutrition/nutrition_details_screen.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_nutrition_card.dart';
import 'package:kman/featuers/serviceprovider/controller/service_provider_controller.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/common/error_text.dart';
import '../../../../../core/constants/imgaeasset.dart';

class CustomGetServiceProviderNutritionStores extends ConsumerWidget {
  const CustomGetServiceProviderNutritionStores({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider)!;
    Tuple2 tuple = Tuple2(user.uid, user.state);
    return ref.watch(getServiceProviderStoreProvider(tuple)).when(
        data: (nutritions) => Expanded(
              child: ListView.builder(
                  itemCount: nutritions.length,
                  itemBuilder: (context, i) {
                    final nutrition = nutritions[i];
                    return InkWell(
                        onTap: () => Get.to(() => NutritionDetailsScreen(
                            nutritionModel: nutrition,
                            collection: Collections.nutritionCollection,
                            fromAsk: false)),
                        child: CustomNutritionCard(
                          nutritionModel: nutrition,
                        ));
                  }),
            ),
        error: (error, StackTrace) {
          return ErrorText(error: error.toString());
        },
        loading: () => LottieBuilder.asset(
              fit: BoxFit.contain,
              AppImageAsset.loading,
              repeat: true,
            ));
  }
}
