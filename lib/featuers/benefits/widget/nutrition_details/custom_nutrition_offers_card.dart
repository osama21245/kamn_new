import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/models/nutrition_model.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../../../models/offers_model.dart';
import '../../../../theme/pallete.dart';
import '../../../orders/controller/orders_controller.dart';

class CustomNutritionOffersCard extends ConsumerStatefulWidget {
  final OffersModel offersModel;
  final NutritionModel nutritionModel;
  final List<String> offersIds;
  final String offerId;
  const CustomNutritionOffersCard(
      {super.key,
      required this.offersModel,
      required this.offersIds,
      required this.nutritionModel,
      required this.offerId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomNutritionOffersCardState();
}

class _CustomNutritionOffersCardState
    extends ConsumerState<CustomNutritionOffersCard> {
  String qrLink = "";
  QRCodeShow(BuildContext context, Size size) async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(
            isShowFlashIcon: true,
          ),
        ));
    if (res is String) {
      if (res == "https://bit.ly/KAMN-كامن-AppsonGooglePlay?r=qr") {
        qrLink = res;
        takeQrDiscount(ref, context, size);
        Get.dialog(
          AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Success'),
                Text(
                  "ID:${widget.offerId}",
                  style: TextStyle(fontSize: size.width * 0.016),
                )
              ],
            ),
            content: Text(
                "You've taken advantage of your ${widget.offersModel.discount}% discount at ${widget.nutritionModel.name}."),
            actions: [
              TextButton(
                onPressed: () => Get.back(), // Close dialog
                child: Text('Close'),
              ),
            ],
          ),
        );
      } else {
        AwesomeDialog(
            dialogBackgroundColor: const Color.fromARGB(255, 231, 230, 230),
            barrierColor: Color.fromARGB(108, 0, 0, 0),
            context: context,
            animType: AnimType.scale,
            dialogType:
                DialogType.error, // Use NO_HEADER to remove the default header
            btnOkOnPress: () {},
            body: Column(children: [
              Text(
                'This Qr is not avaliable',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Muller",
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600),
              ),
            ]))
          ..show();
      }

      setState(() {});
    }
  }

  void takeQrDiscount(WidgetRef ref, BuildContext context, Size size) {
    ref.watch(ordersControllerProvider.notifier).setQrOrder(
        context,
        widget.nutritionModel.id,
        widget.nutritionModel.userId,
        qrLink,
        widget.offersModel,
        Collections.nutritionCollection,
        size);
    widget.offersIds.add(widget.offersModel.id);
  }

  void deleteOffer() {
    ref
        .watch(benefitsControllerProvider.notifier)
        .deleteSportsOffers(widget.nutritionModel.id, widget.offerId, context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(usersProvider);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.width * 0.012),
      child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(94, 255, 255, 255),
              borderRadius: BorderRadius.circular(size.width * 0.02)),
          height: size.height * 0.1,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InstaImageViewer(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size.width * 0.02),
                        child: CachedNetworkImage(
                          imageUrl: widget.offersModel.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text(
                      "${widget.offersModel.title}",
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "${widget.offersModel.description}",
                      maxLines: 3,
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.0265,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Discount ${widget.offersModel.discount}%",
                        style: TextStyle(
                            color: Color.fromARGB(230, 252, 252, 252),
                            fontFamily: "Muller",
                            fontSize: size.width * 0.025,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.017),
                        child: ElevatedButton(
                          onPressed: !widget.offersIds
                                      .contains(widget.offersModel.id) &&
                                  widget.nutritionModel.userId != user!.uid
                              ? () {
                                  QRCodeShow(context, size);
                                  setState(() {});
                                }
                              : widget.nutritionModel.userId == user!.uid
                                  ? () => deleteOffer()
                                  : () {},
                          child: Text(
                            widget.nutritionModel.userId == user.uid
                                ? "Delete"
                                : "Use",
                            style: TextStyle(
                                color: Pallete.whiteColor,
                                fontFamily: "Muller",
                                fontSize:
                                    widget.nutritionModel.userId == user.uid
                                        ? size.width * 0.016
                                        : size.width * 0.021,
                                fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(size.width, size.height * 0.02),
                              backgroundColor: !widget.offersIds
                                      .contains(widget.offersModel.id)
                                  ? const Color.fromARGB(129, 33, 149, 243)
                                  : widget.nutritionModel.userId == user.uid
                                      ? Pallete.redColor
                                      : Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      size.width * 0.02))),
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
