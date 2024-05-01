import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../theme/pallete.dart';

RatingBarItem(WidgetRef ref, String itemimageUrl, String itemname,
    BuildContext context, String servicePorviderId) {
  showDialog(
    context: context,
    barrierDismissible: true, // set to false if you want to force a rating
    builder: (context) => RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        itemname,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),

      // your app's logo?
      image: Image.network(itemimageUrl),
      submitButtonText: 'Submit',
      submitButtonTextStyle: const TextStyle(color: Pallete.fontColor),
      commentHint: "Tell us Your comments", starSize: 28,
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        // ref.watch(ordersControllerProvider.notifier).rating = response.rating;

        ref.watch(ordersControllerProvider.notifier).rateItem(
            servicePorviderId,
            response.comment,
            context,
            response
                .rating); // print('rating: ${response.rating}, comment: ${response.comment}');
      },
    ),
  );
}

  // rateItem() async {
  //   isloading = true;
  //   update();
  //   var response = await itemdetaisData.addreviews(
  //       itemmodel!.itemsId.toString(),
  //       myservices.sharedPreferences.getString("id").toString(),
  //       comment!.text,
  //       Rating == null ? "0" : Rating!);
  //   print(response);
  //   statusRequest = handlingData(response);
  //   print(response);
  //   if (statusRequest == StatusRequest.success) {
  //     showreviews();
  //   } else {
  //     statusRequest = StatusRequest.failure;
  //   }
  //   isloading = false;
  //   update();
  // }


// IconButton(
//                   onPressed: () {
//                     RatingBarItem(
//                       context,
//                       "${Apilinks.linkimageItems}/${controller.itemmodel!.itemsImage}",
//                       databaseTranslate("${controller.itemmodel!.itemsNameAr}",
//                           "${controller.itemmodel!.itemsName}"),
//                     );
//                   },
//                   icon: controller.Rating != null
//                       ? Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                         )
//                       : Icon(Icons.star_border_sharp))