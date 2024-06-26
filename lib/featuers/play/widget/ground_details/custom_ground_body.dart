// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/models/grounds_model.dart';
import '../../../../core/function/awesome_dialog.dart';
import '../../../../theme/pallete.dart';
import '../../controller/play_controller.dart';
import '../../screens/reservision_screen.dart';

// ignore: must_be_immutable
class CustomGroundBody extends ConsumerWidget {
  GroundModel groundModel;
  String collection;
  Size size;
  Color color;
  CustomGroundBody(
      {Key? key,
      required this.groundModel,
      required this.size,
      required this.collection,
      required this.color})
      : super(key: key);

  void gpsTracking(WidgetRef ref, BuildContext context, Size size) {
    if (groundModel.lat == 0.0 && groundModel.long == 0.0) {
      showAwesomeDialog(context, "This store\n has no location added", size);
    } else {
      ref
          .watch(playControllerProvider.notifier)
          .gpsTracking(groundModel.long, groundModel.lat, context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.043),
      child: Column(
        children: [
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(size.width * 0.02),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.02),
                child: CachedNetworkImage(
                  imageUrl: groundModel.image,
                  fit: BoxFit.cover,
                  height: size.height * 0.3,
                )),
          ),
          SizedBox(
            height: size.width * 0.043,
          ),
          Row(
            children: [
              Image.asset(
                "assets/page-1/images/blueLocation.png",
                width: size.width * 0.05,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text(
                "${groundModel.address}",
                style: TextStyle(
                  fontFamily: "Muller",
                  color: Pallete.fontColor,
                  fontSize: size.width * 0.04,
                ),
              )
            ],
          ),
          SizedBox(
            height: size.width * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.013),
            child: Row(
              children: [
                Image.asset(
                  "assets/page-1/images/ph-phone.png",
                  width: size.width * 0.05,
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  "${groundModel.groundnumber}",
                  style: TextStyle(
                    fontFamily: "Muller",
                    color: Pallete.fontColor,
                    fontSize: size.width * 0.04,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 0.065,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.005),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Playground Features",
                  style: TextStyle(
                      fontFamily: "Muller",
                      color: color,
                      fontSize: size.width * 0.043,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 0.02,
          ),
          Text(
            "${groundModel.futuers}",
            maxLines: 4,
            style: TextStyle(
                color: Pallete.fontColor,
                fontSize: size.width * 0.038,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: size.width * 0.12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${groundModel.price} EGP/Hr",
                style: TextStyle(
                    fontFamily: "Muller",
                    color: Pallete.fontColor,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => gpsTracking(ref, context, size),
                  child: Text("GPS", style: TextStyle(color: color)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.whiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                ),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.to(ReservisionScreen(
                    groundOwnerId: groundModel.groundOwnerId,
                    groundImage: groundModel.image,
                    collection: collection,
                    color: color,
                    groundId: groundModel.id,
                  )),
                  child: Text(
                    "Ground Shule",
                    style: TextStyle(color: color),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.whiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02))),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
