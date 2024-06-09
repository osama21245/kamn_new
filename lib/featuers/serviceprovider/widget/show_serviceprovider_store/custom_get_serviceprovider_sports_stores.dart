import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/screens/sports/sports_details_screen.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_sports_card.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/models/sports_model.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/common/error_text.dart';
import '../../../../../core/constants/imgaeasset.dart';
import '../../../orders/screens/my_reservisions/orders_sports_details.dart';
import '../../../orders/widget/sports/custom_card_Pending_sports.dart';
import '../../controller/service_provider_controller.dart';

class CustomGetServiceProviderSportsStores extends ConsumerWidget {
  const CustomGetServiceProviderSportsStores({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider)!;
    Tuple2 tuple = Tuple2(user.uid, user.state);
    return ref.watch(getServiceProviderStoreProvider(tuple)).when(
        data: (sports) => Expanded(
              child: ListView.builder(
                  itemCount: sports.length,
                  itemBuilder: (context, i) {
                    final sport = sports[i] as SportsModel;
                    return InkWell(
                        onTap: () => Get.to(() => SportsDetailsScreen(
                              collection: Collections.sportsCollection,
                              fromAsk: false,
                              sportsModel: sport,
                            )),
                        child: CustomSportsCard(
                          sportsModel: sport,
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
