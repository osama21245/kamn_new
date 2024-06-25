import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../play/screens/reservision_details_screen.dart';
import '../../screens/myplay_screen.dart';
import 'custom_reserve_card.dart';

class CustomGetUserJoinedReservisions extends ConsumerWidget {
  Color color;
  MyReservisionFilterStatus status;
  Size size;
  List<Color> backgroundColor;
  CustomGetUserJoinedReservisions(
      {super.key,
      required this.color,
      required this.status,
      required this.backgroundColor,
      required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(usersProvider)!.uid;
    return ref.watch(getJoinuserreserve(userId)).when(
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
          return ErrorText(error: error.toString());
        },
        loading: () => LottieBuilder.asset(
              fit: BoxFit.contain,
              AppImageAsset.loading,
              repeat: true,
            ));
  }
}
