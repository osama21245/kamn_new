import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:kman/featuers/play/screens/play_home_screen.dart';
import 'package:kman/featuers/user/controller/user_controller.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../user/widget/my Play/custom_reserve_card.dart';
import '../../screens/reservision_details_screen.dart';

class CustomGetJoinedReservisions extends ConsumerWidget {
  final Color color;
  final Size size;
  final List<Color> backgroundColor;
  final String collection;
  CustomGetJoinedReservisions(
      {super.key,
      required this.color,
      required this.backgroundColor,
      required this.size,
      required this.collection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(usersProvider)!.uid;
    return ref.watch(getJoinGroundsProvider(collection)).when(
        data: (reserve) {
          return Expanded(
            child: ListView.builder(
              itemCount: reserve.length,
              itemBuilder: ((context, index) {
                final reservisions = reserve[index];
                return InkWell(
                    onTap: () => Get.to(() => ReservisionDetailsScreen(
                          fromJoinOrLeave: true,
                          reserveModel: reservisions,
                        )),
                    child: CustomReserveCard(
                      color: color,
                      reserveModel: reservisions,
                    ));
              }),
            ),
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
