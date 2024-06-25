import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:kman/featuers/user/widget/my%20Play/custom_ground_reservision_card.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../play/screens/reservision_details_screen.dart';
import '../../screens/myplay_screen.dart';

class CustomGetReservisions extends ConsumerWidget {
  Color color;
  MyReservisionFilterStatus status;
  Size size;
  List<Color> backgroundColor;
  CustomGetReservisions(
      {super.key,
      required this.color,
      required this.status,
      required this.backgroundColor,
      required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(usersProvider)!.uid;
    return ref.watch(getuserreserve(userId)).when(
        data: (reserve) {
          return Expanded(
            child: ListView.builder(
              itemCount: reserve.length,
              itemBuilder: ((context, index) {
                final reservisions = reserve[index];

                return InkWell(
                    onTap: () => Get.to(() => ReservisionDetailsScreen(
                          fromJoinOrLeave: false,
                          reserveModel: reservisions,
                        )),
                    child: CustomGroundReservisionCard(
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
