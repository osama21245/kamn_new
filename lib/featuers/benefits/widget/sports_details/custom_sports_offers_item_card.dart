import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../../../core/constants/collection_constants.dart';
import '../../../../models/offers_items_model.dart';
import '../../../../models/passorder_model.dart';
import '../../../../models/qr_order_model.dart';
import '../../../../models/sports_model.dart';
import '../../../../theme/pallete.dart';
import '../../../orders/controller/orders_controller.dart';
import '../../../payment/screens/toggle_screen.dart';

class CustomSportsOffersItemCard extends ConsumerStatefulWidget {
  final OffersItemsModel offersModel;
  final SportsModel sportsmodel;
  final List<String> offersIds;
  final String offerId;
  const CustomSportsOffersItemCard(
      {super.key,
      required this.offersModel,
      required this.offersIds,
      required this.sportsmodel,
      required this.offerId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomSportsOffersItemCardState();
}

class _CustomSportsOffersItemCardState
    extends ConsumerState<CustomSportsOffersItemCard> {
  String qrLink = "";

  void deleteOffer() {
    ref
        .watch(benefitsControllerProvider.notifier)
        .deleteSportsOffers(widget.sportsmodel.id, widget.offerId, context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(usersProvider);
    QrOrderModel qrOrderModel = QrOrderModel(
        orderid: "",
        storeId: widget.sportsmodel.id,
        offerId: widget.offersModel.id,
        userId: user!.uid,
        offerTitle: widget.offersModel.title,
        offerDescription: "",
        offerPrice: widget.offersModel.price,
        offerDiscount: widget.offersModel.discount,
        category: Collections.sportsCollection,
        image: widget.offersModel.image,
        serviceProviderId: widget.sportsmodel.servicePrividerId,
        qrLink: qrLink,
        date: DateTime.now());

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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price:",
                              style: TextStyle(
                                fontFamily: "Muller",
                                color: Color.fromARGB(255, 250, 220, 52),
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${widget.offersModel.price} EGB",
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: "Muller",
                                color: Pallete.whiteColor,
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount:",
                              style: TextStyle(
                                fontFamily: "Muller",
                                color: Color.fromARGB(255, 250, 220, 52),
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${widget.offersModel.discount}%",
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: "Muller",
                                color: Pallete.whiteColor,
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Final Price:",
                              style: TextStyle(
                                fontFamily: "Muller",
                                color: Color.fromARGB(255, 250, 220, 52),
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: size.width * 0.02,
                            ),
                            Text(
                              "${int.parse(widget.offersModel.price) - ((int.parse(widget.offersModel.discount) / 100) * int.parse(widget.offersModel.price))} EGB",
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: "Muller",
                                color: Pallete.whiteColor,
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                          onPressed: widget.sportsmodel.servicePrividerId ==
                                  user!.uid
                              ? () => deleteOffer()
                              : () {
                                  PassOrderModel passOrderModel = PassOrderModel(
                                      discount: int.parse(
                                          widget.offersModel.discount),
                                      totalPrice:
                                          (int.parse(widget.offersModel.price) -
                                                  ((int.parse(widget.offersModel
                                                              .discount) /
                                                          100) *
                                                      int.parse(widget
                                                          .offersModel.price)))
                                              .toInt(),
                                      price:
                                          int.parse(widget.offersModel.price),
                                      seviceProviderId:
                                          widget.sportsmodel.servicePrividerId,
                                      serviceProviderName: "",
                                      ordername: widget.offersModel.title,
                                      orderDescription: "",
                                      mixOrSeparateOrGroupOrPrivet: "",
                                      orderplanTime: "",
                                      storeId: widget.sportsmodel.id);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ToggleScreen(
                                          qrOrderModel: qrOrderModel,
                                          passOrderModel: passOrderModel,
                                          collection:
                                              Collections.sportsCollection)));
                                },
                          child: Text(
                            widget.sportsmodel.servicePrividerId == user!.uid
                                ? "Delete"
                                : "Use",
                            style: TextStyle(
                                color: Pallete.whiteColor,
                                fontFamily: "Muller",
                                fontSize:
                                    widget.sportsmodel.servicePrividerId ==
                                            user.uid
                                        ? size.width * 0.029
                                        : size.width * 0.034,
                                fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(size.width, size.height * 0.02),
                              backgroundColor:
                                  widget.sportsmodel.servicePrividerId ==
                                          user.uid
                                      ? Pallete.redColor
                                      : const Color.fromARGB(129, 33, 149, 243),
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
