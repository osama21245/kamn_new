import 'package:flutter/material.dart';
import 'package:kman/core/class/categories.dart';
import 'package:kman/featuers/add_serviceprovider/screens/serviceprovider_requests.dart';
import 'package:kman/featuers/play/screens/add_ground_screen.dart';
import 'package:kman/theme/pallete.dart';
import '../../../core/common/custom_uppersec.dart';
import '../../play/widget/play_home/custom_home_card.dart';

class GroundCategoriesRequestScreen extends StatelessWidget {
  final bool isUser;
  const GroundCategoriesRequestScreen({super.key, required this.isUser});

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
            title: isUser ? "Which sport ?" : "Play",
            color: Pallete.fontColor,
            size: size,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          const Divider(
            thickness: 3,
            color: Colors.black,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: size.width * 0.03),
                  child: InkWell(
                    onTap: () {
                      isUser
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddGroundScreen(
                                  fromAsk: true,
                                  collection: categoriesList[index].name)))
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ServiceProviderRequestsScreen(
                                      collection: categoriesList[index].name)));
                    },
                    child: CustomPlayCategoryCard(
                        size: size,
                        image: categoriesList[index].imageurl,
                        section: categoriesList[index].name),
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
