import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/common/prices_card.dart';
import 'package:kman/featuers/orders/screens/orders_screen.dart';

import 'package:lottie/lottie.dart';

import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../controller/benefits_controller.dart';
import '../benefits_home/custom_medical_card.dart';

class CustomGetMedicalPrices extends ConsumerWidget {
  String benefitsId;
  String serviceProviderId;
  CustomGetMedicalPrices(
      {super.key, required this.benefitsId, required this.serviceProviderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getMedicalPricesProvider(benefitsId)).when(
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
