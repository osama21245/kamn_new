import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/play/screens/ground_details_screen.dart';
import 'package:kman/featuers/play/widget/play/custom_play_card.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../theme/pallete.dart';
import '../../play/controller/play_controller.dart';

class CustomGetGroundsRequests extends ConsumerWidget {
  final String collection;
  final Size size;
  const CustomGetGroundsRequests(
      {super.key, required this.collection, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getGroundsRequestsProvider(collection)).when(
        data: (ground) {
          return Expanded(
            child: ListView.builder(
              itemCount: ground.length,
              itemBuilder: ((context, index) {
                final grounds = ground[index];
                return InkWell(
                    onTap: () {
                      Get.to(GroundDetailsScreen(
                        fromAsk: true,
                        color: Pallete.football,
                        collection: collection,
                        backgroundColor: Pallete.footballGridentColors,
                        groundModel: grounds,
                        size: size,
                      ));
                    },
                    child: CustomPlayCard(
                        color: Pallete.football, groundModel: grounds));
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
