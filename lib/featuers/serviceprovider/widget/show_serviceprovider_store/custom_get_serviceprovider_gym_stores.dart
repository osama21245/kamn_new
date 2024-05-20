import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';

import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/featuers/orders/screens/my_reservisions/orders_gym_details.dart';
import 'package:kman/featuers/orders/widget/customcardPending.dart';
import 'package:kman/featuers/orders/widget/gym/custom_card_Pending_gym.dart';
import 'package:kman/featuers/serviceprovider/controller/service_provider_controller.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/common/error_text.dart';
import '../../../../../core/constants/imgaeasset.dart';
import '../../../coaches-gyms/screens/gym/gym_locations_screen.dart';
import '../../../coaches-gyms/widget/coaches-gyms_home/custom_gyms_card.dart';

class CustomGetServiceProviderGymStores extends ConsumerWidget {
  CustomGetServiceProviderGymStores({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider)!;
    Tuple2 tuple = Tuple2(user.uid, user.state);
    return ref.watch(getServiceProviderStoreProvider(tuple)).when(
        data: (gyms) => Expanded(
              child: ListView.builder(
                  itemCount: gyms.length,
                  itemBuilder: (context, i) {
                    final gym = gyms[i];
                    return InkWell(
                        onTap: () => Get.to(() => GymLocationsScreen(
                              collection: "gym",
                              gymModel: gym,
                              fromAsk: false,
                            )),
                        child: CustomGymCard(
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
