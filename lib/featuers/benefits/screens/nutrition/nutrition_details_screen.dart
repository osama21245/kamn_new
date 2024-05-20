import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/benefits/widget/nutrition_details/custom_add_nutrition_offers_items_button.dart';
import 'package:kman/featuers/benefits/widget/nutrition_details/custom_nutrition_offers_item_card.dart';
import 'package:kman/models/nutrition_model.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/collection_constants.dart';
import '../../../../edit_collaborator_state_screen.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../coaches-gyms/controller/coaches-gyms_controller.dart';
import '../../../orders/controller/orders_controller.dart';
import '../../../play/controller/play_controller.dart';
import '../../../play/widget/play/showrating.dart';
import '../../controller/benefits_controller.dart';
import '../../widget/nutrition_details/custom_add_nutrition_offers_button.dart';
import '../../widget/nutrition_details/custom_nutrition_offers_card.dart';
import '../../widget/sports_details/custom_material_button.dart';
import '../../widget/sports_details/custom_sports_offers_item_card.dart';
import '../../../../core/common/update_gallery_screen.dart';

class NutritionDetailsScreen extends ConsumerStatefulWidget {
  final String collection;
  final NutritionModel nutritionModel;
  final bool fromAsk;
  const NutritionDetailsScreen(
      {super.key,
      required this.nutritionModel,
      required this.collection,
      required this.fromAsk});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NutritionDetailsScreenState();
}

enum NutritionFilterStatus {
  Description,
  Offers,
}

enum NutrtionsOffersStatus {
  Public,
  on_items,
}

Alignment _alignment = Alignment.centerLeft;

NutritionFilterStatus status = NutritionFilterStatus.Description;
NutrtionsOffersStatus offresstatus = NutrtionsOffersStatus.Public;

class _NutritionDetailsScreenState
    extends ConsumerState<NutritionDetailsScreen> {
  acceptNutrition(
    BuildContext context,
  ) {
    ref.watch(benefitsControllerProvider.notifier).setNutritionRequest(
        context,
        widget.nutritionModel.image,
        widget.nutritionModel.name,
        widget.nutritionModel.about,
        widget.nutritionModel.faceBook,
        widget.nutritionModel.instgram,
        widget.nutritionModel.whatsApp,
        widget.nutritionModel.dynamicLink,
        widget.nutritionModel.lat,
        widget.nutritionModel.long,
        widget.nutritionModel.discount,
        widget.nutritionModel.gallery,
        widget.nutritionModel.region,
        widget.nutritionModel.specialization);

    ref
        .watch(benefitsControllerProvider.notifier)
        .deleteNutritionRequest(widget.nutritionModel.id, context);
  }

  refusesNutrition() {
    ref
        .watch(benefitsControllerProvider.notifier)
        .deleteNutritionRequest(widget.nutritionModel!.id, context);
  }

  List<String> offersIds = [];
  bool loopDone = false;
  StatusRequest statusRequest = StatusRequest.success;

  openWhatsApp(String phone, BuildContext context) {
    ref.watch(benefitsControllerProvider.notifier).openWhatsApp(phone, context);
  }

  openLink(String link, BuildContext context) {
    ref.watch(coachesGymsControllerProvider.notifier).openLink(link, context);
  }

  void gpsTracking() {
    ref.watch(playControllerProvider.notifier).gpsTracking(
        widget.nutritionModel.long, widget.nutritionModel.lat, context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(usersProvider)!;
    Size size = MediaQuery.of(context).size;
    final tuple = Tuple2(user.uid, widget.nutritionModel.id);
    return Scaffold(
        body: HandlingDataView(
      statusRequest: statusRequest,
      widget: SafeArea(
          child: ListView(
        children: [
          CustomUpperSec(
            size: size,
            color: Pallete.fontColor,
            title: "Nutrition",
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Divider(
            thickness: 3,
            color: Colors.black,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.032),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height * 0.08,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: Pallete.listofGridientCard,
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width * 0.02),
                              topRight: Radius.circular(size.width * 0.02))),
                      height: size.height * 0.655,
                      width: size.width,
                      child: Text(""),
                    ),
                    InkWell(
                        onTap: () => gpsTracking(),
                        child: CustomMaterialButton(
                            color: Pallete.greenButton,
                            size: size,
                            title: "Gps Tracking"))
                  ],
                ),
                Positioned.fill(
                    child: Column(
                  children: [
                    Container(
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: Pallete.listofGridientCard,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: Center(
                            child: CircleAvatar(
                                backgroundColor: Pallete.primaryColor,
                                radius: size.width * 0.2,
                                backgroundImage: NetworkImage(
                                  widget.nutritionModel.image,
                                )),
                          ),
                        )),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    Text(
                      "${widget.nutritionModel.name}",
                      style: TextStyle(
                          fontFamily: "Muller",
                          color: Pallete.whiteColor,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.width * 0.008,
                    ),
                    Text(
                      "Nutrition",
                      style: TextStyle(
                        fontFamily: "Muller",
                        color: Pallete.whiteColor,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    RatingDisplayWidget(
                        rating: widget.nutritionModel.rating,
                        color: Pallete.ratingColor,
                        size: size.width * 0.06),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.09,
                          vertical: size.height * 0.012),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              for (NutritionFilterStatus filterStatus
                                  in NutritionFilterStatus.values)
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (filterStatus ==
                                            NutritionFilterStatus.Description) {
                                          status =
                                              NutritionFilterStatus.Description;
                                          _alignment = Alignment.centerLeft;
                                        } else if (filterStatus ==
                                            NutritionFilterStatus.Offers) {
                                          status = NutritionFilterStatus.Offers;
                                          _alignment = Alignment.centerRight;
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02),
                                      child: Container(
                                          width: size.width * 0.26,
                                          height: size.height * 0.033,
                                          decoration: BoxDecoration(
                                            color: Pallete.greyColor,
                                            borderRadius: BorderRadius.circular(
                                                size.width * 0.010),
                                          ),
                                          child: Center(
                                            child: Text(
                                              filterStatus.name,
                                              style: TextStyle(
                                                  color: Pallete.whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: size.width * 0.03),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          AnimatedAlign(
                            alignment: _alignment,
                            duration: const Duration(milliseconds: 200),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              child: Container(
                                width: size.width * 0.34,
                                height: size.height * 0.033,
                                decoration: BoxDecoration(
                                  color: Pallete.fontColor,
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.010),
                                ),
                                child: Center(
                                  child: Text(
                                    status.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.width * 0.03),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    status == NutritionFilterStatus.Offers
                        ? offresstatus == NutrtionsOffersStatus.Public
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            offresstatus =
                                                NutrtionsOffersStatus.Public;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: offresstatus ==
                                                      NutrtionsOffersStatus
                                                          .Public
                                                  ? const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Pallete
                                                              .fontColor))
                                                  : null),
                                          child: Text(
                                            "Public",
                                            style: TextStyle(
                                                color: offresstatus ==
                                                        NutrtionsOffersStatus
                                                            .Public
                                                    ? Pallete.fontColor
                                                    : const Color.fromARGB(
                                                        255, 133, 133, 133),
                                                fontFamily: "Inter",
                                                fontSize: size.width * 0.04,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            offresstatus =
                                                NutrtionsOffersStatus.on_items;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: offresstatus ==
                                                      NutrtionsOffersStatus
                                                          .on_items
                                                  ? const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Pallete
                                                              .fontColor))
                                                  : null),
                                          child: Text(
                                            "Items",
                                            style: TextStyle(
                                                color: offresstatus ==
                                                        NutrtionsOffersStatus
                                                            .on_items
                                                    ? Pallete.fontColor
                                                    : const Color.fromARGB(
                                                        255, 133, 133, 133),
                                                fontFamily: "Inter",
                                                fontSize: size.width * 0.04,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 0.01,
                                  ),
                                  Container(
                                    height: size.height * 0.32,
                                    child: ref
                                        .watch(getQrOrdersProvider(tuple))
                                        .when(
                                            data: (qrmodel) {
                                              return ref
                                                  .watch(user.uid ==
                                                          widget.nutritionModel
                                                              .userId
                                                      ? getNutritionOffersStreamProvider(
                                                          widget.nutritionModel
                                                              .id)
                                                      : getNutritionOffersProvider(
                                                          widget.nutritionModel
                                                              .id))
                                                  .when(
                                                      data: (offers) {
                                                        if (loopDone == false) {
                                                          for (var offer
                                                              in qrmodel) {
                                                            offersIds.add(
                                                                offer.offerId);
                                                            print(
                                                                "${offer.offerId}");
                                                            loopDone = true;
                                                          }
                                                        }

                                                        return ListView.builder(
                                                            itemCount:
                                                                offers.length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              final offer =
                                                                  offers[i];
                                                              return CustomNutritionOffersCard(
                                                                  offersIds:
                                                                      offersIds,
                                                                  offerId:
                                                                      offer.id,
                                                                  nutritionModel:
                                                                      widget
                                                                          .nutritionModel,
                                                                  offersModel:
                                                                      offer);
                                                            });
                                                      },
                                                      error:
                                                          (error, StackTrace) {
                                                        print(error);

                                                        return ErrorText(
                                                            error: error
                                                                .toString());
                                                      },
                                                      loading: () => const Text(
                                                          "Wait...."));
                                            },
                                            error: (error, StackTrace) {
                                              print(error);

                                              return ErrorText(
                                                  error: error.toString());
                                            },
                                            loading: () => InkWell(
                                                onTap: () => setState(() {}),
                                                child: Container(
                                                  child: Text("Wait...."),
                                                ))),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            offresstatus =
                                                NutrtionsOffersStatus.Public;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: offresstatus ==
                                                      NutrtionsOffersStatus
                                                          .Public
                                                  ? const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Pallete
                                                              .fontColor))
                                                  : null),
                                          child: Text(
                                            "Public",
                                            style: TextStyle(
                                                color: offresstatus ==
                                                        NutrtionsOffersStatus
                                                            .Public
                                                    ? Pallete.fontColor
                                                    : const Color.fromARGB(
                                                        255, 133, 133, 133),
                                                fontFamily: "Inter",
                                                fontSize: size.width * 0.04,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            offresstatus =
                                                NutrtionsOffersStatus.on_items;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: offresstatus ==
                                                      NutrtionsOffersStatus
                                                          .on_items
                                                  ? const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Pallete
                                                              .fontColor))
                                                  : null),
                                          child: Text(
                                            "Items",
                                            style: TextStyle(
                                                color: offresstatus ==
                                                        NutrtionsOffersStatus
                                                            .on_items
                                                    ? Pallete.fontColor
                                                    : const Color.fromARGB(
                                                        255, 133, 133, 133),
                                                fontFamily: "Inter",
                                                fontSize: size.width * 0.04,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 0.01,
                                  ),
                                  Container(
                                    height: size.height * 0.32,
                                    child: ref
                                        .watch(getQrOrdersProvider(tuple))
                                        .when(
                                            data: (qrmodel) {
                                              return ref
                                                  .watch(user.uid ==
                                                          widget.nutritionModel
                                                              .userId
                                                      ? getNutritionOffersItemsStreamProvider(
                                                          widget.nutritionModel
                                                              .id)
                                                      : getNutritionOffersItemsProvider(
                                                          widget.nutritionModel
                                                              .id))
                                                  .when(
                                                      data: (offers) {
                                                        if (loopDone == false) {
                                                          for (var offer
                                                              in qrmodel) {
                                                            offersIds.add(
                                                                offer.offerId);
                                                            print(
                                                                "${offer.offerId}");
                                                            loopDone = true;
                                                          }
                                                        }

                                                        return ListView.builder(
                                                            itemCount:
                                                                offers.length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              final offer =
                                                                  offers[i];
                                                              return CustomNutritionOffersItemCard(
                                                                  offersIds:
                                                                      offersIds,
                                                                  offerId:
                                                                      offer.id,
                                                                  nutritionModel:
                                                                      widget
                                                                          .nutritionModel,
                                                                  offersModel:
                                                                      offer);
                                                            });
                                                      },
                                                      error:
                                                          (error, StackTrace) {
                                                        print(error);

                                                        return ErrorText(
                                                            error: error
                                                                .toString());
                                                      },
                                                      loading: () =>
                                                          Text("Wait...."));
                                            },
                                            error: (error, StackTrace) {
                                              print(error);

                                              return ErrorText(
                                                  error: error.toString());
                                            },
                                            loading: () => InkWell(
                                                onTap: () => setState(() {}),
                                                child: Container(
                                                  child: Text("Wait...."),
                                                ))),
                                  ),
                                ],
                              )
                        : Padding(
                            padding: EdgeInsets.only(left: size.width * 0.02),
                            child: Container(
                              height: size.height * 0.175,
                              child: ListView(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "About",
                                        style: TextStyle(
                                          fontFamily: "Muller",
                                          color:
                                              Color.fromARGB(255, 250, 220, 52),
                                          fontSize: size.width * 0.037,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        widget.nutritionModel.about,
                                        style: TextStyle(
                                          fontFamily: "Muller",
                                          height: size.width * 0.0037,
                                          color: Pallete.whiteColor,
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (widget.fromAsk)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomElevatedButton(
                                            size: size,
                                            color: Pallete.greenButton,
                                            title: "Accept",
                                            sizeofwidth: size.width * 0.3,
                                            sizeofhight: size.height * 0.03,
                                            onTap: () =>
                                                acceptNutrition(context)),
                                        SizedBox(
                                          width: size.width * 0.01,
                                        ),
                                        CustomElevatedButton(
                                            size: size,
                                            color: Pallete.redColor,
                                            title: "Refuse",
                                            sizeofwidth: size.width * 0.3,
                                            sizeofhight: size.height * 0.03,
                                            onTap: () => refusesNutrition())
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ),
                    if (status == NutritionFilterStatus.Description)
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gallery",
                              style: TextStyle(
                                fontFamily: "Muller",
                                color: const Color.fromARGB(255, 250, 220, 52),
                                fontSize: size.width * 0.037,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.009,
                            ),
                            InkWell(
                              onLongPress: user.uid ==
                                      widget.nutritionModel.userId
                                  ? () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateGalleryScreen(
                                                gymlLocatyionId: "",
                                                collection: Collections
                                                    .nutritionCollection,
                                                gallery: widget
                                                    .nutritionModel.gallery,
                                                storeId:
                                                    widget.nutritionModel.id,
                                              )))
                                  : () {},
                              child: Container(
                                padding: EdgeInsets.all(size.width * 0.01),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                    border: Border.all(
                                        width: 2,
                                        color: const Color.fromARGB(
                                            118, 255, 255, 255))),
                                height: size.height * 0.15,
                                width: size.width,
                                child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.nutritionModel.gallery.length,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 1,
                                            crossAxisCount: 1),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.02),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              size.width * 0.03),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: widget
                                                .nutritionModel.gallery[index],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (user.uid == widget.nutritionModel.userId ||
                        user.state == "1")
                      offresstatus == NutrtionsOffersStatus.Public
                          ? Opacity(
                              opacity: 0.5,
                              child: CustomAddNutritionOffersButton(
                                  nutritionId: widget.nutritionModel.id))
                          : Opacity(
                              opacity: 0.5,
                              child: CustomAddNutritionOffersItemsButton(
                                  nutritionId: widget.nutritionModel.id))
                  ],
                )),
                if (widget.nutritionModel.faceBook != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.115,
                      child: InkWell(
                        onTap: () =>
                            openLink(widget.nutritionModel.faceBook, context),
                        child: Image.asset(
                          "assets/page-1/images/facebook-logo.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.nutritionModel.whatsApp != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.16,
                      child: InkWell(
                        onTap: () => openWhatsApp(
                            widget.nutritionModel.whatsApp, context),
                        child: Image.asset(
                          "assets/page-1/images/whatsapp.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.nutritionModel.instgram != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.2,
                      child: InkWell(
                        onTap: () =>
                            openLink(widget.nutritionModel.instgram, context),
                        child: Image.asset(
                          "assets/page-1/images/instagram.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.nutritionModel.dynamicLink != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.241,
                      child: InkWell(
                        onTap: () => openLink(
                            widget.nutritionModel.dynamicLink, context),
                        child: Image.asset(
                          "assets/page-1/images/world-wide-web.png",
                          width: size.width * 0.08,
                        ),
                      )),
                Positioned(
                  left: size.width * 0.03,
                  top: size.height * 0.117,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/page-1/images/kamn_noBG.png",
                        width: size.width * 0.08,
                      ),
                      Text(
                        "Kamn Discount",
                        maxLines: 3,
                        style: TextStyle(
                          wordSpacing: -0.4,
                          fontFamily: "Muller",
                          color: Pallete.whiteColor,
                          fontSize: size.width * 0.033,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.nutritionModel.userId == "" &&
                          user.state == "1")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Get.to(() =>
                                  EditCollaboratorStateScreen(
                                      collection: widget.collection,
                                      id: widget.nutritionModel.id)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.red,
                                    child: Text(
                                      "NOT ACTIVE",
                                      maxLines: 3,
                                      style: TextStyle(
                                        wordSpacing: -0.4,
                                        fontFamily: "Muller",
                                        color: Pallete.whiteColor,
                                        fontSize: size.width * 0.033,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    ));
  }
}
