import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';

import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/featuers/orders/screens/my_reservisions/sure_medical_reservision.dart';
import 'package:kman/featuers/orders/widget/medical/custom_card_medical_reservisions.dart';
import 'package:kman/featuers/orders/widget/customcardPending.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/common/error_text.dart';
import '../../../../../core/constants/imgaeasset.dart';

class CustomGetUserMedicalReservisions extends ConsumerWidget {
  CustomGetUserMedicalReservisions({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider);
    return ref.watch(getUserMedicalReservisionProvider(user!.uid)).when(
        data: (medicalReservisions) => medicalReservisions.isEmpty
            ? LottieBuilder.asset(
                fit: BoxFit.contain,
                AppImageAsset.nodata,
                repeat: true,
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: medicalReservisions.length,
                    itemBuilder: (context, i) {
                      final medicalReservision = medicalReservisions[i];
                      return InkWell(
                          onTap: () => Get.to(SureMedicalReservision(
                                medicalReservisionModel: medicalReservision,
                              )),
                          child: CustomcardMedicalReservisions(
                            medicalReservisionModel: medicalReservision,
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
