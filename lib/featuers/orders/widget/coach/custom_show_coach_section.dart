import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/coaches-gyms/screens/coach/coaches_details_screen.dart';
import 'package:kman/models/coache_model.dart';
import 'package:kman/theme/pallete.dart';

class CustomShowCoachSection extends ConsumerWidget {
  final CoacheModel coacheModel;
  const CustomShowCoachSection({super.key, required this.coacheModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 17),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Get.to(() => CoachesDetailsScreen(
                              fromAsk: false,
                              collection: Collections.coachCollection,
                              coacheModel: coacheModel,
                            )),
                        child: CircleAvatar(
                            backgroundColor: Pallete.primaryColor,
                            radius: size.width * 0.05,
                            backgroundImage:
                                CachedNetworkImageProvider(coacheModel.image)),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Column(
                        children: [
                          Text(
                            coacheModel.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Pallete.primaryColor,
                                fontSize: size.width * 0.04),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        "Experience : ${coacheModel.experience}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    // CustomElevatedButton(
                    //     size: size,
                    //     color: Pallete.fontColor,
                    //     title: "Rating",
                    //     sizeofwidth: size.width * 0.2,
                    //     sizeofhight: size.height * 0.35,
                    //     onTap: () {
                    //       RatingBarItem(ref, coacheModel.image,
                    //           coacheModel.name, context, coacheModel.userId);
                    //     })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
