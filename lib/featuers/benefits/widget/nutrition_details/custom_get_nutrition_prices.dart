import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/common/prices_card.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../controller/benefits_controller.dart';

class CustomGetNutritionPrices extends ConsumerWidget {
  final String benefitsId;
  final String serviceProviderId;
  const CustomGetNutritionPrices(
      {super.key, required this.benefitsId, required this.serviceProviderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getNutritionsPricesProvider(benefitsId)).when(
        data: (prices) => Expanded(
                child: PricesCard(
              pricesModel: prices,
              serviceProviderId: serviceProviderId,
            )),
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
