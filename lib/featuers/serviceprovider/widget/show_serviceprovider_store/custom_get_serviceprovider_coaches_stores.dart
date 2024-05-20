import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/coaches-gyms/screens/coach/coaches_details_screen.dart';
import 'package:kman/featuers/orders/widget/coach/custom_card_Pending_coach.dart';
import 'package:kman/featuers/serviceprovider/controller/service_provider_controller.dart';
import 'package:kman/models/coache_model.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/common/error_text.dart';
import '../../../../../core/constants/imgaeasset.dart';
import '../../../coaches-gyms/widget/coaches-gyms_home/custom_coaches_card.dart';
import '../../../orders/screens/orders_screen.dart';

class CustomGetServiceProvidercoachesStores extends ConsumerWidget {
  const CustomGetServiceProvidercoachesStores({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider)!;
    Tuple2 tuple = Tuple2(user.uid, user.state);
    return ref.watch(getServiceProviderStoreProvider(tuple)).when(
        data: (coaches) => Expanded(
              child: ListView.builder(
                  itemCount: coaches.length,
                  itemBuilder: (context, i) {
                    final coach = coaches[i] as CoacheModel;
                    return InkWell(
                        onTap: () => Get.to(CoachesDetailsScreen(
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
