import 'package:flutter/material.dart';
import 'package:kman/featuers/serviceprovider/screens/add_serviceprovider/grounds_categories_request_screen.dart';
import 'package:kman/featuers/coaches-gyms/screens/gym/add_gym_screen.dart';

import '../../../../core/class/orders_categoriy.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../theme/pallete.dart';
import '../../../benefits/screens/medical/add_medical_screen.dart';
import '../../../benefits/screens/nutrition/add_nutrition_screen.dart';
import '../../../benefits/screens/sports/add_sports_screen.dart';
import '../../../coaches-gyms/screens/coach/add_coach_screen.dart';
import '../../../play/widget/play_home/custom_home_card.dart';

class UserMakeRequestScreen extends StatelessWidget {
  const UserMakeRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
        child: Column(
          children: [
            CustomUpperSec(
              title: "Which one you are",
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
                itemCount: ordersCategoriyList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: size.width * 0.03),
                    child: InkWell(
                      onTap: () {
                        if (ordersCategoriyList[index].name == "Coaches") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AddCoachScreen(fromAsk: true)));
                        } else if (ordersCategoriyList[index].name ==
                            "Medical") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AddMedicalScreen(fromAsk: true)));
                        } else if (ordersCategoriyList[index].name ==
                            "Nutrition") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AddNutrtionScreen(fromAsk: true)));
                        } else if (ordersCategoriyList[index].name ==
                            "Grounds") {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const GroundCategoriesRequestScreen(
                                    isUser: true),
                          ));
                        } else if (ordersCategoriyList[index].name ==
                            "Sports shop") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AddSportsScreen(fromAsk: true)));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AddgymScreen(fromAsk: true)));
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
