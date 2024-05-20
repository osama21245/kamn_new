import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/common/custom_uppersec.dart';
import 'package:kman/featuers/serviceprovider/screens/add_serviceprovider/serviceprovider_requests.dart';
import '../../../../core/class/orders_categoriy.dart';
import '../../../../theme/pallete.dart';
import '../../../play/widget/play_home/custom_home_card.dart';
import 'grounds_categories_request_screen.dart';

class AcceptChooseYourServiceScreen extends ConsumerWidget {
  const AcceptChooseYourServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
        child: Column(
          children: [
            CustomUpperSec(
              title: "Choose your service",
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
                        if (ordersCategoriyList[index].name == "Coaches") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ServiceProviderRequestsScreen(
                                      collection: "Coaches")));
                        } else if (ordersCategoriyList[index].name ==
                            "Medical") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ServiceProviderRequestsScreen(
                                      collection: "Medical")));
                        } else if (ordersCategoriyList[index].name ==
                            "Nutrition") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ServiceProviderRequestsScreen(
                                      collection: "Nutrition")));
                        } else if (ordersCategoriyList[index].name ==
                            "Grounds") {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const GroundCategoriesRequestScreen(
                                    isUser: false),
                          ));
                        } else if (ordersCategoriyList[index].name ==
                            "Sports shop") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ServiceProviderRequestsScreen(
                                      collection: "Sports shop")));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ServiceProviderRequestsScreen(
                                      collection: "Gyms")));
                        }
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
      ),
    ));
  }
}
