import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/benefits/screens/medical/medical_details_screen.dart';
import 'package:kman/models/medical_model.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../benefits/widget/benefits_home/custom_medical_card.dart';

class CustomGetMedicalRequests extends ConsumerWidget {
  final String region;
  const CustomGetMedicalRequests({super.key, required this.region});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MedicalModel> filterList;
    return ref.watch(getMedicalRequestProvider).when(
        data: (medicals) {
          filterList = medicals
              .where((element) => element.region.contains(region))
              .toList();
          return region == "All"
              ? Expanded(
                  child: ListView.builder(
                      itemCount: medicals.length,
                      itemBuilder: (context, i) {
                        final medical = medicals[i];
                        return InkWell(
                            onTap: () => Get.to(() => MedicalDetailsScreen(
                                  fromAsk: true,
                                  medicalModel: medical,
                                  collection: "medical",
                                )),
                            child: CustomMedicalCard(
                              medicalModel: medical,
                            ));
                      }),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: filterList.length,
                      itemBuilder: (context, i) {
                        final medical = filterList[i];
                        return InkWell(
                            onTap: () => Get.to(() => MedicalDetailsScreen(
                                  fromAsk: true,
                                  medicalModel: medical,
                                  collection: "medical",
                                )),
                            child: CustomMedicalCard(
                              medicalModel: medical,
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
