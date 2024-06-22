import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/common/custom_uppersec.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/featuers/orders/widget/order_details/custom_user_section.dart';
import 'package:kman/featuers/user/controller/user_controller.dart';
import 'package:kman/models/qr_order_model.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../../theme/pallete.dart';
import '../../widget/nutrition/custom_nutrition_prices_secion.dart';
import '../../widget/sports/custom_sports_prices_secion.dart';

class OrderNutritionDetailsScreen extends ConsumerWidget {
  final QrOrderModel qrorderModel;
  final bool fromserviceProviderScreen;
  const OrderNutritionDetailsScreen(
      {super.key,
      required this.fromserviceProviderScreen,
      required this.qrorderModel});

  deleteOrder(WidgetRef ref, BuildContext context) {
    ref
        .watch(ordersControllerProvider.notifier)
        .deleteQrOrder(qrorderModel.orderid, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar:
          fromserviceProviderScreen || qrorderModel.offerPrice == "Public Offer"
              ? null
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                  child: ElevatedButton(
                    onPressed: () => deleteOrder(ref, context),
                    child: Text(
                      'Delete your order',
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width, size.height * 0.04),
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02))),
                  ),
                ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 5),
                child: CustomUpperSec(
                    size: size,
                    color: Pallete.fontColor,
                    title: "Nutrition reservision")),
            SizedBox(
              height: size.height * 0.027,
            ),
            Container(
              height: size.height * 0.73,
              child: ListView(
                children: [
                  CustomNutritionPricesSection(
                    qrOrderModel: qrorderModel,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.0),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 17.0, top: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Order : ",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: Pallete.primaryColor)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ListTile(
                                  title: Text("${qrorderModel.offerTitle}"),
                                  subtitle:
                                      Text("${qrorderModel.offerDescription}"),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  if (fromserviceProviderScreen)
                    ref.watch(getUserDataProviderr(qrorderModel.userId)).when(
                        data: (userData) =>
                            CustomUserSection(userModel: userData),
                        error: (error, StackTrace) {
                          print(error);

                          return ErrorText(error: error.toString());
                        },
                        loading: () => LottieBuilder.asset(
                              fit: BoxFit.contain,
                              AppImageAsset.loading,
                              repeat: true,
                            )),
                  // if (!fromserviceProviderScreen)
                  //   ref
                  //       .watch(getUserDataProviderr(qrorderModel.ordersUsersid))
                  //       .when(
                  //           data: (userData) =>
                  //               CustomUserSection(userModel: userData),
                  //           error: (error, StackTrace) {
                  //             print(error);

                  //             return ErrorText(error: error.toString());
                  //           },
                  //           loading: () => LottieBuilder.asset(
                  //                 fit: BoxFit.contain,
                  //                 AppImageAsset.loading,
                  //                 repeat: true,
                  //               )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
