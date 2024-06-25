import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/coaches-gyms/screens/gym/gym_locations_screen.dart';
import 'package:kman/featuers/coaches-gyms/widget/coaches-gyms_home/custom_gyms_card.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../controller/coaches-gyms_controller.dart';

class CustomGetGyms extends ConsumerWidget {
  final bool fromOrders;
  CustomGetGyms({super.key, required this.fromOrders});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getGymsProvider).when(
        data: (gyms) => Expanded(
              child: ListView.builder(
                  itemCount: gyms.length,
                  itemBuilder: (context, i) {
                    final gym = gyms[i];
                    return OpenContainer(
                        transitionType: ContainerTransitionType.fade,
                        transitionDuration: Duration(seconds: 1),
                        openBuilder: (BuildContext context, VoidCallback _) {
                          return GymLocationsScreen(
                            collection: "gym",
                            gymModel: gym,
                            fromAsk: false,
                          );
                        },
                        closedElevation: 0.0,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        closedColor: Color.fromARGB(0, 245, 246, 247),
                        closedBuilder: (BuildContext context,
                                VoidCallback openContainer) =>
                            CustomGymCard(
                              gymModel: gym,
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
