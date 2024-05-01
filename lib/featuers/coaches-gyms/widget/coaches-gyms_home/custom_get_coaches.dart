import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/coaches-gyms/screens/coach/coaches_details_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../orders/screens/orders_screen.dart';
import '../../controller/coaches-gyms_controller.dart';
import 'custom_coaches_card.dart';

class CustomGetCoaches extends ConsumerWidget {
  bool fromOrders;
  CustomGetCoaches({super.key, required this.fromOrders});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getCoachesProvider).when(
        data: (coaches) => Expanded(
              child: ListView.builder(
                  itemCount: coaches.length,
                  itemBuilder: (context, i) {
                    final coach = coaches[i];
                    return InkWell(
                        onTap: () => fromOrders
                            ? Get.to(() => OrdersScreen(
                                serviceProviderOrUserId: coach.userId))
                            : Get.to(CoachesDetailsScreen(
                                fromAsk: false,
                                coacheModel: coach,
                                collection: "coach",
                              )),
                        child: CustomCoachesCard(
                          coacheModel: coach,
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
