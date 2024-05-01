// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/benefits/screens/medical/finish_medical_reservision.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../../models/medical_model.dart';
import '../../../../theme/pallete.dart';

class CustomGetMedicalServices extends ConsumerWidget {
  final MedicalModel medicalModel;
  CustomGetMedicalServices({super.key, required this.medicalModel});

  void deleteMedicalService(
      WidgetRef ref, String servicesId, BuildContext context) {
    ref
        .watch(benefitsControllerProvider.notifier)
        .deleteMedicalServices(medicalModel.id, servicesId, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider);
    return Container(
      height: size.height * 0.3,
      child: ref.watch(getMedicalServicesProvider(medicalModel.id)).when(
          data: (services) {
            return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, i) {
                  final service = services[i];
                  return Container(
                      child: ListTile(
                          title: Text("${service.title}"),
                          subtitle: Text("${service.description}"),
                          leading: Container(
                            padding: EdgeInsets.all(size.width * 0.02),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02),
                              color: Color.fromARGB(99, 0, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Discount ${service.discount}%",
                                  style: TextStyle(
                                      color: Color.fromARGB(230, 252, 252, 252),
                                      fontFamily: "Muller",
                                      fontSize: size.width * 0.025,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.017),
                            child: ElevatedButton(
                              onPressed: user!.uid == medicalModel.userId
                                  ? () => deleteMedicalService(
                                      ref, service.id, context)
                                  : () => Get.to(() => FinishMedicalReservision(
                                        medicalModel: medicalModel,
                                        medicalServicesModel: service,
                                      )),
                              child: Text(
                                user.uid == medicalModel.userId
                                    ? "Delete"
                                    : "Use",
                                style: TextStyle(
                                    color: Pallete.whiteColor,
                                    fontFamily: "Muller",
                                    fontSize: user.uid == medicalModel.userId
                                        ? size.width * 0.029
                                        : size.width * 0.034,
                                    fontWeight: FontWeight.w600),
                              ),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      size.width * 0.1, size.height * 0.02),
                                  backgroundColor: user.uid ==
                                          medicalModel.userId
                                      ? Pallete.redColor
                                      : const Color.fromARGB(129, 33, 149, 243),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.02))),
                            ),
                          )));
                });
          },
          error: (error, StackTrace) {
            print(error);

            return ErrorText(error: error.toString());
          },
          loading: () => LottieBuilder.asset(
                fit: BoxFit.contain,
                AppImageAsset.loading,
                repeat: true,
              )),
    );
  }
}
