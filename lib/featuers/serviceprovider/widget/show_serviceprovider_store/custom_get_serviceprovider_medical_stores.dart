import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/screens/medical/medical_details_screen.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_medical_card.dart';
import 'package:kman/featuers/orders/screens/my_reservisions/sure_medical_reservision.dart';
import 'package:kman/featuers/orders/widget/medical/custom_card_medical_reservisions.dart';
import 'package:kman/models/medical_model.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/common/error_text.dart';
import '../../../../../core/constants/imgaeasset.dart';
import '../../controller/service_provider_controller.dart';

class CustomGetServiceProviderMedicalStores extends ConsumerWidget {
  const CustomGetServiceProviderMedicalStores({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider)!;
    Tuple2 tuple = Tuple2(user.uid, user.state);
    return ref.watch(getServiceProviderStoreProvider(tuple)).when(
        data: (medicals) => Expanded(
              child: ListView.builder(
                  itemCount: medicals.length,
                  itemBuilder: (context, i) {
                    final medical = medicals[i] as MedicalModel;
                    return InkWell(
                        onTap: () => Get.to(MedicalDetailsScreen(
                            medicalModel: medical,
                            fromAsk: false,
                            collection: Collections.medicalCollection)),
                        child: CustomMedicalCard(
                          medicalModel: medical,
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
