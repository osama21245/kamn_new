import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/core/constants/constants.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/benefits/screens/sports/update_sports_screen.dart';
import 'package:kman/featuers/benefits/widget/sports_details/custom_material_button.dart';
import 'package:kman/featuers/benefits/widget/sports_details/custom_sports_offers_card.dart';
import 'package:kman/featuers/orders/controller/orders_controller.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:kman/featuers/play/widget/play/showrating.dart';
import 'package:kman/featuers/user/controller/user_controller.dart';
import 'package:kman/models/sports_model.dart';
import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/common/custom_icon_uppersec.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/function/awesome_dialog.dart';
import '../../../../core/function/goTo.dart';
import '../../../../edit_collaborator_state_screen.dart';
import '../../../../theme/pallete.dart';
import '../../../coaches-gyms/controller/coaches-gyms_controller.dart';
import '../../../orders/screens/service_provider_reservisions/service_provider_sports_reservision_screen.dart';
import '../../widget/sports_details/custom_add_sports_offers_button.dart';
import '../../widget/sports_details/custom_add_sports_offers_items_button.dart';
import '../../widget/sports_details/custom_sports_offers_item_card.dart';
import '../../../../core/common/update_gallery_screen.dart';
import 'refuse_sports_request.dart';

class SportsDetailsScreen extends ConsumerStatefulWidget {
  final SportsModel sportsModel;
  final String collection;
  final bool fromAsk;
  const SportsDetailsScreen(
      {super.key,
      required this.sportsModel,
      required this.collection,
      required this.fromAsk});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SportsDetailsScreenState();
}

enum SportsFilterStatus {
  Description,
  Offers,
}

enum SportsOffersStatus {
  Public,
  on_items,
}

class _SportsDetailsScreenState extends ConsumerState<SportsDetailsScreen> {
  acceptSportShop(
    BuildContext context,
  ) {
    ref.watch(benefitsControllerProvider.notifier).setSportsRequest(
          context,
          widget.sportsModel.image,
          widget.sportsModel.name,
          widget.sportsModel.about,
          widget.sportsModel.faceBook,
          widget.sportsModel.instgram,
          widget.sportsModel.whatsApp,
          widget.sportsModel.dynamicLink,
          widget.sportsModel.lat,
          widget.sportsModel.long,
          widget.sportsModel.discount,
          widget.sportsModel.gallery,
          widget.sportsModel.region,
        );

    ref
        .watch(benefitsControllerProvider.notifier)
        .deleteSportsRequest(widget.sportsModel!.id, context);
// send message to user
    ref.watch(userControllerProvider.notifier).sendInboxToUser(
        title: "Congratulations",
        description: "Your service has been added successfully to kamn",
        imageFile: null,
        defImage: true,
        userId: widget.sportsModel.servicePrividerId,
        context: context);
    // update user state

    ref.watch(authControllerProvider.notifier).updateUserServiceStatus(
        "8", widget.sportsModel.servicePrividerId, context);
  }

  String qrLink = "";
  Alignment _alignment = Alignment.centerLeft;
  bool loopDone = false;
  SportsFilterStatus status = SportsFilterStatus.Description;
  SportsOffersStatus offresstatus = SportsOffersStatus.Public;
  StatusRequest statusRequest = StatusRequest.success;
  List<String> offersIds = [];

  void gpsTracking(Size size) {
    if (widget.sportsModel.lat == 0.0 && widget.sportsModel.long == 0.0) {
      showAwesomeDialog(context, "This store\n has no location added", size);
    } else {
      ref.watch(playControllerProvider.notifier).gpsTracking(
          widget.sportsModel.long, widget.sportsModel.lat, context);
    }
  }

  openWhatsApp(String phone, BuildContext context) {
    ref.watch(benefitsControllerProvider.notifier).openWhatsApp(phone, context);
  }

  openLink(String link, BuildContext context) {
    ref.watch(coachesGymsControllerProvider.notifier).openLink(link, context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider);
    final tuple = Tuple2(user!.uid, widget.sportsModel.id);
    statusRequest = ref.watch(benefitsControllerProvider);

    return Scaffold(
        body: HandlingDataView(
      statusRequest: statusRequest,
      widget: SafeArea(
          child: ListView(
        children: [
          widget.sportsModel.servicePrividerId == user.uid || user.state == "1"
              ? CustomIconUpperSec(
                  size: size,
                  color: Pallete.fontColor,
                  title: "Sport",
                  onTapAction: () {
                    goToScreen(context,
                        UpdateSportsScreen(sportsModel: widget.sportsModel));
                  },
                )
              : CustomUpperSec(
                  size: size,
                  color: Pallete.fontColor,
                  title: "sports",
                ),
          SizedBox(
            height: size.height * 0.02,
          ),
          const Divider(
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
                SingleChildScrollView(
                  child: Column(
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
                        height: size.height * 0.67,
                        width: size.width,
                        child: const Text(""),
                      ),
                      InkWell(
                          onTap: () => gpsTracking(size),
                          child: CustomMaterialButton(
                              serviceProviderId:
                                  widget.sportsModel.servicePrividerId,
                              fun: () => goToScreen(context,
                                  ServiceProviderSportsReservisionsScreen()),
                              color: Pallete.greenButton,
                              size: size,
                              title: "Gps Tracking"))
                    ],
                  ),
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
                                  widget.sportsModel.image,
                                )),
                          ),
                        )),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    Text(
                      "${widget.sportsModel.name}",
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
                      "Sports Shop",
                      style: TextStyle(
                        fontFamily: "Muller",
                        color: Pallete.whiteColor,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    RatingDisplayWidget(
                        rating: widget.sportsModel.rating,
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
                              for (SportsFilterStatus filterStatus
                                  in SportsFilterStatus.values)
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (filterStatus ==
                                            SportsFilterStatus.Description) {
                                          status =
                                              SportsFilterStatus.Description;
                                          _alignment = Alignment.centerLeft;
                                        } else if (filterStatus ==
                                            SportsFilterStatus.Offers) {
                                          status = SportsFilterStatus.Offers;
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
                    status == SportsFilterStatus.Offers
                        ? offresstatus == SportsOffersStatus.Public
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
                                                SportsOffersStatus.Public;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: offresstatus ==
                                                      SportsOffersStatus.Public
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
                                                        SportsOffersStatus
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
                                                SportsOffersStatus.on_items;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: offresstatus ==
                                                      SportsOffersStatus
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
                                                        SportsOffersStatus
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
                                                          widget.sportsModel
                                                              .servicePrividerId
                                                      ? getSportsOffersStreamProvider(
                                                          widget.sportsModel.id)
                                                      : getSportsOffersProvider(
                                                          widget
                                                              .sportsModel.id))
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
                                                              return CustomSportsOffersCard(
                                                                  offersIds:
                                                                      offersIds,
                                                                  offerId:
                                                                      offer.id,
                                                                  sportsmodel:
                                                                      widget
                                                                          .sportsModel,
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
                                                  child: const Text("Wait...."),
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
                                                SportsOffersStatus.Public;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: offresstatus ==
                                                      SportsOffersStatus.Public
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
                                                        SportsOffersStatus
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
                                                SportsOffersStatus.on_items;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: offresstatus ==
                                                      SportsOffersStatus
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
                                                        SportsOffersStatus
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
                                                          widget.sportsModel
                                                              .servicePrividerId
                                                      ? getSportsOffersItemsStreamProvider(
                                                          widget.sportsModel.id)
                                                      : getSportsOffersItemsProvider(
                                                          widget
                                                              .sportsModel.id))
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
                                                              return CustomSportsOffersItemCard(
                                                                  offersIds:
                                                                      offersIds,
                                                                  offerId:
                                                                      offer.id,
                                                                  sportsmodel:
                                                                      widget
                                                                          .sportsModel,
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
                                                  child: const Text("Wait...."),
                                                ))),
                                  ),
                                ],
                              )
                        : InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => UpdateSportsScreen(
                              //         sportsModel: widget.sportsModel)));
                            },
                            child: Padding(
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
                                            color: const Color.fromARGB(
                                                255, 250, 220, 52),
                                            fontSize: size.width * 0.037,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${widget.sportsModel.about}",
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
                                                  acceptSportShop(context)),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          CustomElevatedButton(
                                              size: size,
                                              color: Pallete.redColor,
                                              title: "Refuse",
                                              sizeofwidth: size.width * 0.3,
                                              sizeofhight: size.height * 0.03,
                                              onTap: () => goToScreen(
                                                  context,
                                                  RefuseSportsRequestScreen(
                                                      sportsModel:
                                                          widget.sportsModel)))
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    if (status == SportsFilterStatus.Description)
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
                                      widget.sportsModel.servicePrividerId
                                  ? () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateGalleryScreen(
                                                gymlLocatyionId: "",
                                                collection: Collections
                                                    .sportsCollection,
                                                gallery:
                                                    widget.sportsModel.gallery,
                                                storeId: widget.sportsModel.id,
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
                                        widget.sportsModel.gallery.length,
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
                                                .sportsModel.gallery[index],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                )),
                if (widget.sportsModel.faceBook != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.115,
                      child: InkWell(
                        onTap: () =>
                            openLink(widget.sportsModel.faceBook, context),
                        child: Image.asset(
                          "assets/page-1/images/facebook-logo.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (user.uid == widget.sportsModel.servicePrividerId ||
                    user.state == "1")
                  offresstatus == SportsOffersStatus.Public
                      ? Positioned(
                          right: size.width * 0.15,
                          bottom: size.height * 0.08,
                          child: Opacity(
                              opacity: 0.5,
                              child: CustomAddSportsOffersButton(
                                  sportsId: widget.sportsModel.id)),
                        )
                      : Positioned(
                          right: size.width * 0.15,
                          bottom: size.height * 0.08,
                          child: Opacity(
                              opacity: 0.5,
                              child: CustomAddSportsOffersItemsButton(
                                  sportsId: widget.sportsModel.id)),
                        ),
                if (widget.sportsModel.whatsApp != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.16,
                      child: InkWell(
                        onTap: () =>
                            openWhatsApp(widget.sportsModel.whatsApp, context),
                        child: Image.asset(
                          "assets/page-1/images/whatsapp.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.sportsModel.instgram != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.2,
                      child: InkWell(
                        onTap: () =>
                            openLink(widget.sportsModel.instgram, context),
                        child: Image.asset(
                          "assets/page-1/images/instagram.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.sportsModel.dynamicLink != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.241,
                      child: InkWell(
                        onTap: () =>
                            openLink(widget.sportsModel.dynamicLink, context),
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
                      if (widget.sportsModel.servicePrividerId == "" &&
                          user.state == "1")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Get.to(() =>
                                  EditCollaboratorStateScreen(
                                      collection: widget.collection,
                                      id: widget.sportsModel.id)),
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
