import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/coaches-gyms/screens/gym/gym_details_screen.dart';
import 'package:kman/featuers/coaches-gyms/widget/coaches-gyms_home/custom_gyms_card.dart';
import 'package:kman/featuers/coaches-gyms/widget/locations/custom_gym_locations_card.dart';
import 'package:kman/featuers/orders/screens/orders_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../controller/coaches-gyms_controller.dart';

class CustomGetLocations extends ConsumerWidget {
  String gymId;
  String image;
  CustomGetLocations({super.key, required this.gymId, required this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getGymLocationsProvider(gymId)).when(
        data: (gyms) => Expanded(
              child: ListView.builder(
                  itemCount: gyms.length,
                  itemBuilder: (context, i) {
                    final gymLocation = gyms[i];
                    return InkWell(
                        onTap: () => Get.to(() => GymDetailsScreen(
                              gymModel: gymLocation,
                              collection: "gym",
                            )),
                        child: CustomGymLocationCard(
                          gymLocationsModel: gymLocation,
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
