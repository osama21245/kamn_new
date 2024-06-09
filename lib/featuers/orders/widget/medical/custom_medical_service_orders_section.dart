import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/benefits/screens/medical/medical_details_screen.dart';
import 'package:kman/models/medical_reservision_model.dart';
import 'package:kman/theme/pallete.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';

class CustomMedicalServiceOrdersSection extends ConsumerWidget {
  final MedicalReservisionModel medicalReservisionModel;
  const CustomMedicalServiceOrdersSection(
      {super.key, required this.medicalReservisionModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return ref
        .watch(getMedicalOrdersDataProvider(medicalReservisionModel.storeId))
        .when(
            data: (medicalModel) => Padding(
                  padding: EdgeInsets.all(size.width * 0.01),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => Get.to(() => MedicalDetailsScreen(
                                      fromAsk: false,
                                      collection: Collections.medicalCollection,
                                      medicalModel: medicalModel,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 17),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Pallete.primaryColor,
                                          radius: size.width * 0.05,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  medicalModel.image)),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "${medicalModel.name}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Pallete.primaryColor,
                                            fontSize: size.width * 0.04),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text(
                                  "Specialization : ${medicalModel.specialization}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text("City : ${medicalModel.city} ",
                                    style: const TextStyle(fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text("Region  : ${medicalModel.region}",
                                    style: const TextStyle(fontSize: 16)),
                              ),
                              const Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Order : ${medicalReservisionModel.ordername}",
                                        style: const TextStyle(fontSize: 16)),
                                    // CustomElevatedButton(
                                    //     size: size,
                                    //     color: Pallete.fontColor,
                                    //     title: "Rating",
                                    //     sizeofwidth: size.width * 0.2,
                                    //     sizeofhight: size.height * 0.35,
                                    //     onTap: () {
                                    //       RatingBarItem(
                                    //           ref,
                                    //           medicalModel.image,
                                    //           medicalModel.name,
                                    //           context,
                                    //           medicalModel.userId);
                                    //     })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
