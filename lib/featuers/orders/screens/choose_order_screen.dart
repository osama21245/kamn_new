import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/orders/screens/get_serviceproviders_screen.dart';
import '../../../core/class/orders_categoriy.dart';
import '../../../core/common/custom_uppersec.dart';
import '../../../theme/pallete.dart';
import '../../play/widget/play_home/custom_home_card.dart';

class ChooseOrderScreen extends StatelessWidget {
  const ChooseOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.06),
      child: Column(
        children: [
          SizedBox(
            height: size.width * 0.04,
          ),
          CustomUpperSec(
            title: "Orders",
            color: Pallete.fontColor,
            size: size,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Divider(
            thickness: 3,
            color: Colors.black,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ordersCategoriyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: size.width * 0.03),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => GetServiceProviderScreen(
                          collection: ordersCategoriyList[index].name));
                    },
                    child: CustomPlayCategoryCard(
                        size: size,
                        image: ordersCategoriyList[index].imageurl,
                        section: ordersCategoriyList[index].name),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
