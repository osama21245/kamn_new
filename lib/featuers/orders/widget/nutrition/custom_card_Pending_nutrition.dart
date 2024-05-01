import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/core/common/booking_dataTime_converted.dart';
import 'package:kman/featuers/orders/screens/my_reservisions/orders_gym_details.dart';
import 'package:kman/featuers/orders/screens/my_reservisions/orders_sports_details.dart';
import 'package:kman/featuers/orders/screens/ordersdetails.dart';
import 'package:kman/models/qr_order_model.dart';
import 'package:kman/theme/pallete.dart';

import '../../../../models/order_model.dart';

class CustomcardPendingNutrition extends StatelessWidget {
  final Size size;
  final bool fromserviceProviderScreen;
  final QrOrderModel qrorderModel;

  const CustomcardPendingNutrition({
    super.key,
    required this.qrorderModel,
    required this.size,
    required this.fromserviceProviderScreen,
  });

  @override
  Widget build(BuildContext context) {
    final day = DateConverted.getDate(qrorderModel.date);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        "${qrorderModel.offerTitle}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 24, 24, 24),
                            fontSize: size.width * 0.04),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "${day}",
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
                  child: Text("Price: ${qrorderModel.offerPrice}\$",
                      style: const TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text("Discount: ${qrorderModel.offerDiscount}\%",
                      style: const TextStyle(fontSize: 16)),
                ),
                const Divider(thickness: 2),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text("Kamn discount",
                          style: TextStyle(
                              fontSize: 14, color: Pallete.primaryColor)),
                    ),
                    const Spacer(),
                    MaterialButton(
                      minWidth: size.width * 0.07,
                      textColor: Colors.white,
                      color: Pallete.primaryColor,
                      onPressed: () => Get.to(() => OrderSportsDetailsScreen(
                            fromserviceProviderScreen:
                                fromserviceProviderScreen,
                            qrorderModel: qrorderModel,
                          )),
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
    );
  }
}
