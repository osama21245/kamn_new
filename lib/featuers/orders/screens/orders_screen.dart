import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/orders/widget/custom_get_modorders.dart';
import '../../../core/common/custom_uppersec.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';

class OrdersScreen extends ConsumerWidget {
  String? serviceProviderOrUserId;
  OrdersScreen({super.key, this.serviceProviderOrUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(usersProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          CustomUpperSec(
            size: size,
            color: Pallete.fontColor,
            title: "Orders",
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
          // user!.state == "0"
          //     ? CustomGetUserOrders()
          // :
          CustomGetModOrders(serviceProviderOrUserId: serviceProviderOrUserId!)
        ],
      ),
    ));
  }
}
