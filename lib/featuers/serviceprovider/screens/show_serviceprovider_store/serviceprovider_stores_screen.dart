import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/orders/widget/service_provider_reservisions/custom_get_service_provider_nutrition_reservisions.dart';
import 'package:kman/featuers/orders/widget/service_provider_reservisions/custom_get_service_provider_sports_reservisions.dart';
import 'package:kman/featuers/serviceprovider/widget/show_serviceprovider_store/custom_get_serviceprovider_coaches_stores.dart';
import 'package:kman/featuers/serviceprovider/widget/show_serviceprovider_store/custom_get_serviceprovider_gym_stores.dart';
import 'package:kman/featuers/serviceprovider/widget/show_serviceprovider_store/custom_get_serviceprovider_medical_stores.dart';

import '../../../../HandlingDataView.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/common/custom_play_uppersec_logo.dart';
import '../../../../core/providers/checkInternet.dart';
import '../../../../theme/pallete.dart';

class ServiceProviderStoresScreen extends ConsumerStatefulWidget {
  const ServiceProviderStoresScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceProviderStoresScreenState();
}

class _ServiceProviderStoresScreenState
    extends ConsumerState<ServiceProviderStoresScreen> {
  StatusRequest statusRequest = StatusRequest.success;

  checkinternet() async {
    setState(() {
      statusRequest = StatusRequest.loading2;
    });

    if (await checkInternet()) {
      setState(() {
        statusRequest = StatusRequest.success;
      });
    } else {
      setState(() {
        statusRequest = StatusRequest.offlinefalire2;
      });
    }
  }

  @override
  void initState() {
    checkinternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = ref.read(usersProvider)!;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          CustomPlayUpperSecLogo(
            title: "My Stores",
            color: Pallete.fontColor,
            size: size,
            onLogoTap: () {},
          ),
          SizedBox(
            height: size.height * 0.013,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.13),
            child: const Divider(
              thickness: 2,
              color: Color.fromARGB(94, 146, 146, 146),
            ),
          ),
          SizedBox(
            height: size.width * 0.01,
          ),
          HandlingDataView(
              statusRequest: statusRequest,
              widget: user.state == "4"
                  ? CustomGetServiceProvidercoachesStores()
                  : user.state == "5"
                      ? CustomGetServiceProviderGymStores()
                      : CustomGetServiceProviderMedicalStores())
        ],
      ),
    ));
  }
}
