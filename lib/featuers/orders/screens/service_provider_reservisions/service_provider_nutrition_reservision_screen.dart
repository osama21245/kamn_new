import 'package:flutter/material.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/common/custom_play_uppersec_logo.dart';
import '../../../../core/providers/checkInternet.dart';
import '../../../../theme/pallete.dart';
import '../../widget/service_provider_reservisions/custom_get_service_provider_nutrition_reservisions.dart';
import '../../widget/service_provider_reservisions/custom_get_service_provider_sports_reservisions.dart';

class ServiceProviderNutritionReservisionsScreen extends StatefulWidget {
  const ServiceProviderNutritionReservisionsScreen({super.key});

  @override
  State<ServiceProviderNutritionReservisionsScreen> createState() =>
      _ServiceProviderNutritionReservisionsScreenState();
}

class _ServiceProviderNutritionReservisionsScreenState
    extends State<ServiceProviderNutritionReservisionsScreen> {
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
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          CustomPlayUpperSecLogo(
            title: "My Reservisions",
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
              widget: CustomGetServiceProviderNutritionReservisions())
        ],
      ),
    ));
  }
}
