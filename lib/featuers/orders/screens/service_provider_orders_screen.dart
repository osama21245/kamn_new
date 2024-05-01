import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/common/custom_uppersec.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/orders/widget/service_provider_orders/custom_get_service_provider_recived_orders.dart';
import 'package:kman/theme/pallete.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/providers/checkInternet.dart';

class ServiceProviderOrdersScreen extends ConsumerStatefulWidget {
  const ServiceProviderOrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceProviderOrdersScreenState();
}

class _ServiceProviderOrdersScreenState
    extends ConsumerState<ServiceProviderOrdersScreen> {
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
    final user = ref.read(usersProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomUpperSec(
              size: size,
              color: Pallete.fontColor,
              title: "Recived Reservisions",
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
              thickness: 3,
              color: Colors.black,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            HandlingDataView(
                statusRequest: statusRequest,
                widget: CustomGetServiceProviderRecivedOrders())
          ],
        ),
      ),
    );
  }
}
