import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/models/medical_reservision_model.dart';
import 'package:kman/theme/pallete.dart';

import '../../screens/my_reservisions/sure_medical_reservision.dart';

class CustomcardMedicalReservisions extends StatelessWidget {
  final Size size;
  final bool fromserviceProviderScreen;
  final MedicalReservisionModel medicalReservisionModel;

  const CustomcardMedicalReservisions({
    super.key,
    required this.medicalReservisionModel,
    required this.size,
    required this.fromserviceProviderScreen,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 17),
                    child: Row(
                      children: [
                        Text(
                          "${medicalReservisionModel.ordersServiceProviderName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 24, 24, 24),
                              fontSize: size.width * 0.04),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            "${medicalReservisionModel.ordersDatetime}",
                            style: TextStyle(
                                fontSize: 9,
                                color: Pallete.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      "Your reservision : ${medicalReservisionModel.ordername}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("Address : ${medicalReservisionModel.address}",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                        "Payment Method  : ${medicalReservisionModel.ordersPaymenttype}",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("Day: ${medicalReservisionModel.day}",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  const Divider(thickness: 2),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                            "Discount  : ${medicalReservisionModel.orderdiscount}\%",
                            style: TextStyle(
                                fontSize: 14, color: Pallete.primaryColor)),
                      ),
                      const Spacer(),
                      MaterialButton(
                        minWidth: size.width * 0.07,
                        textColor: Colors.white,
                        color: Pallete.primaryColor,
                        onPressed: () => Get.to(SureMedicalReservision(
                          medicalReservisionModel: medicalReservisionModel,
                        )),
                        // Get.to(() {}
                        //  OrderDetailsScreen(
                        //       fromserviceProviderScreen:
                        //           fromserviceProviderScreen,
                        //       orderModel: orderModel,
                        //     )
                        //   ),
                        child: const Text(
                          "Detials",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      // SizedBox(
                      //   width: size.width * 0.02,
                      // ),
                      // if (orderModel.ordersStatus == "0")
                      //   MaterialButton(
                      //     minWidth: size.width * 0.07,
                      //     textColor: Colors.white,
                      //     color: Pallete.primaryColor,
                      //     onPressed: () =>
                      //         OrderDetailsScreen(orderModel: orderModel),
                      //     child: const Text(
                      //       "Remove",
                      //       style: TextStyle(fontSize: 12),
                      //     ),
                      //   )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
