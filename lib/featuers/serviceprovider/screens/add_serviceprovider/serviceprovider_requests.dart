import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/serviceprovider/widget/custom_get_grounds_requests.dart';
import 'package:kman/featuers/serviceprovider/widget/custom_get_medical_requests.dart';

import '../../../../HandlingDataView.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/providers/checkInternet.dart';
import '../../../../theme/pallete.dart';
import '../../widget/custom_get_coaches_requests.dart';
import '../../widget/custom_get_gyms_requests.dart';
import '../../widget/custom_get_nutrition_requests.dart';
import '../../widget/custom_get_sports.dart';

class ServiceProviderRequestsScreen extends ConsumerStatefulWidget {
  final String collection;
  const ServiceProviderRequestsScreen({super.key, required this.collection});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceProviderRequestsScreenState();
}

class _ServiceProviderRequestsScreenState
    extends ConsumerState<ServiceProviderRequestsScreen> {
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
    //final user = ref.read(usersProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomUpperSec(
              size: size,
              color: Pallete.fontColor,
              title: widget.collection,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Divider(
              thickness: 3,
              color: Colors.black,
            ),
            InkWell(
              onTap: () {},
              child:
                  //showSearch(
                  //         context: context,
                  //         delegate: SearchGroundDelegate(
                  //           ref,
                  //           widget.collection!,
                  //           color,
                  //           backGroundGridentColor,
                  //           size,
                  //         )),
                  //     child: ),

                  SizedBox(
                height: size.height * 0.01,
              ),
            ),
            HandlingDataView(
                statusRequest: statusRequest,
                widget: widget.collection == "Gyms"
                    ? CustomGetGymsRequests()
                    : widget.collection == "Coaches"
                        ? const CustomGetCoachesRequests()
                        : widget.collection == "Medical"
                            ? const CustomGetMedicalRequests(
                                region: "All",
                              )
                            : widget.collection == "Nutrition"
                                ? const CustomGetNutritionRequest(
                                    region: "All",
                                  )
                                : widget.collection == "Sports shop"
                                    ? const CustomGetSportsRequests(
                                        region: "All",
                                      )
                                    : CustomGetGroundsRequests(
                                        size: size,
                                        collection: widget.collection,
                                      ))
          ],
        ),
      ),
    );
  }
}
