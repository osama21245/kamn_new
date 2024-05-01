import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/post/screens/add_post_type_screen.dart';
import 'package:kman/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  navigateToTypePostScreen(String type, BuildContext context) {
    Get.to(() => AddPostTypeScreen(type: type));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double sizedBoxsSize = 120;
    final double iconSize = 60;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => navigateToTypePostScreen("image", context),
              child: SizedBox(
                height: sizedBoxsSize,
                width: sizedBoxsSize,
                child: Card(
                  color: Pallete.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Icon(
                    Icons.image_outlined,
                    size: iconSize,
                  )),
                  elevation: 16,
                ),
              ),
            ),
            InkWell(
              onTap: () => navigateToTypePostScreen("text", context),
              child: SizedBox(
                height: sizedBoxsSize,
                width: sizedBoxsSize,
                child: Card(
                  color: Pallete.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Icon(
                    Icons.font_download_outlined,
                    size: iconSize,
                  )),
                  elevation: 16,
                ),
              ),
            ),
            InkWell(
              onTap: () => navigateToTypePostScreen("link", context),
              child: SizedBox(
                height: sizedBoxsSize,
                width: sizedBoxsSize,
                child: Card(
                  color: Pallete.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Icon(
                    Icons.link_outlined,
                    size: iconSize,
                  )),
                  elevation: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
