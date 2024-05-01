import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_get_medical.dart';
import 'package:kman/featuers/benefits/widget/benefits_home/custom_get_nutrition.dart';
import 'package:kman/featuers/coaches-gyms/widget/coaches-gyms_home/custom_get_coaches.dart';
import 'package:kman/featuers/coaches-gyms/widget/coaches-gyms_home/custom_get_gyms.dart';
import '../../../HandlingDataView.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/common/custom_uppersec.dart';
import '../../../core/providers/checkInternet.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';

class GetServiceProviderScreen extends ConsumerStatefulWidget {
  final String collection;
  const GetServiceProviderScreen({super.key, required this.collection});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GetServiceProviderScreenState();
}

class _GetServiceProviderScreenState
    extends ConsumerState<GetServiceProviderScreen> {
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
              title: "${widget.collection}",
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
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
                    ? CustomGetGyms(
                        fromOrders: true,
                      )
                    : widget.collection == "Coaches"
                        ? CustomGetCoaches(
                            fromOrders: true,
                          )
                        : widget.collection == "Medical"
                            ? const CustomGetMedical(
                                region: "All",
                                fromOrders: true,
                              )
                            : widget.collection == "Nutrition"
                                ? const CustomGetNutrition(
                                    region: "All",
                                    fromOrders: true,
                                  )
                                : CustomGetCoaches(
                                    fromOrders: true,
                                  ))
          ],
        ),
      ),
    );
  }
}
