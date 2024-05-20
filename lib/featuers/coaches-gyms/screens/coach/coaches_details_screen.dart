import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/common/custom_elevated_button.dart';
import 'package:kman/edit_collaborator_state_screen.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/featuers/coaches-gyms/widget/coaches_details/coach_prices_card.dart';
import 'package:kman/featuers/coaches-gyms/widget/coaches_details/custom_add_coachplans_button.dart';
import 'package:kman/models/coach_prices_model.dart';
import 'package:kman/models/coache_model.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/common/update_gallery_screen.dart';
import '../../../../core/constants/collection_constants.dart';
import '../../../../theme/pallete.dart';

import '../../../play/widget/play/showrating.dart';

class CoachesDetailsScreen extends ConsumerStatefulWidget {
  final String collection;
  final CoacheModel? coacheModel;
  final bool fromAsk;
  const CoachesDetailsScreen(
      {super.key,
      this.coacheModel,
      required this.collection,
      required this.fromAsk});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoachesDetailsState();
}

enum CoachesFilterStatus { CV, Gallery }

enum CoachFilterStatusPricse { main, ONLINE, OFLINE }

Alignment _alignment = Alignment.centerLeft;

CoachesFilterStatus status = CoachesFilterStatus.CV;
CoachFilterStatusPricse status2 = CoachFilterStatusPricse.main;

openWhatsApp(WidgetRef ref, String phone, BuildContext context) {
  ref
      .watch(coachesGymsControllerProvider.notifier)
      .openWhatsApp(phone, context);
}

openLink(WidgetRef ref, String link, BuildContext context) {
  ref.watch(coachesGymsControllerProvider.notifier).openLink(link, context);
}

class _CoachesDetailsState extends ConsumerState<CoachesDetailsScreen> {
  acceptCoach(
    BuildContext context,
  ) {
    ref.watch(coachesGymsControllerProvider.notifier).setCoacheRequest(
          widget.coacheModel!.name,
          context,
          widget.coacheModel!.education,
          widget.coacheModel!.faceBook,
          widget.coacheModel!.dynamicLink,
          widget.coacheModel!.instgram,
          widget.coacheModel!.whatsAppNum,
          widget.coacheModel!.categoriry,
          widget.coacheModel!.experience,
          widget.coacheModel!.image,
          widget.coacheModel!.gallery,
          widget.coacheModel!.benefits,
        );

    ref
        .watch(coachesGymsControllerProvider.notifier)
        .deleteCoachRequest(widget.coacheModel!.id, context);
  }

  refuseCoach() {
    ref
        .watch(coachesGymsControllerProvider.notifier)
        .deleteCoachRequest(widget.coacheModel!.id, context);
  }

  @override
  void dispose() {
    status2 = CoachFilterStatusPricse.main;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(usersProvider);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomUpperSec(
              size: size,
              color: Pallete.fontColor,
              title: "COACHES",
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Divider(
              thickness: 3,
              color: Colors.black,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.032),
              child: Stack(
                children: [
                  Column(
                    children: [
                      AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: status2 == CoachFilterStatusPricse.main
                              ? size.height * 0.1
                              : size.height * 0.03),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: Pallete.listofGridient,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size.width * 0.02),
                                topRight: Radius.circular(size.width * 0.02))),
                        height: status2 == CoachFilterStatusPricse.main
                            ? size.height * 0.62
                            : size.height * 0.7,
                        width: size.width,
                        child: Text(""),
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(size.width * 0.02),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(227, 66, 209, 109),
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(size.width * 0.02),
                                  bottomRight:
                                      Radius.circular(size.width * 0.02))),
                          height: size.height * 0.06,
                          width: size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: Row(
                              children: [
                                status2 == CoachFilterStatusPricse.main
                                    ? Container(child: Text("             "))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            status2 =
                                                CoachFilterStatusPricse.main;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Pallete.whiteColor,
                                        )),
                                SizedBox(
                                  width: size.width * 0.23,
                                ),
                                Text(
                                  "${status2.name}",
                                  style: TextStyle(
                                      fontFamily: "Muller",
                                      color: Pallete.whiteColor,
                                      fontSize: size.width * 0.053,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (status2 == CoachFilterStatusPricse.ONLINE)
                    Positioned.fill(
                      child: Column(
                        children: [
                          CoachPricesCard(
                            coachId: widget.coacheModel!.id,
                            collection: widget.collection,
                            usermodel: user!,
                            coachName: widget.coacheModel!.name,
                            pricesModel: CoachPricesModel(
                                prices: widget.coacheModel!.onlineprices,
                                planDescriptions:
                                    widget.coacheModel!.onlineplanDescriptions,
                                planName: widget.coacheModel!.onlinePlanName,
                                discount: widget.coacheModel!.onlinediscount,
                                points: widget.coacheModel!.onlinepoints,
                                isGroup: widget.coacheModel!.onlineisGroup,
                                reservisionTimes:
                                    widget.coacheModel!.onlineReservisionTimes),
                            serviceProviderId: widget.coacheModel!.userId,
                          ),
                          if (user.state == "1")
                            CustomAddCoachPlansButton(
                              coachPricesModel: CoachPricesModel(
                                  prices: widget.coacheModel!.onlineprices,
                                  planDescriptions: widget
                                      .coacheModel!.onlineplanDescriptions,
                                  planName: widget.coacheModel!.onlinePlanName,
                                  discount: widget.coacheModel!.onlinediscount,
                                  points: widget.coacheModel!.onlinepoints,
                                  isGroup: widget.coacheModel!.onlineisGroup,
                                  reservisionTimes: widget
                                      .coacheModel!.onlineReservisionTimes),
                              collection: "online",
                              coachId: widget.coacheModel!.id,
                            )
                        ],
                      ),
                    ),
                  if (status2 == CoachFilterStatusPricse.OFLINE)
                    Positioned.fill(
                      child: Column(
                        children: [
                          CoachPricesCard(
                            coachId: widget.coacheModel!.id,
                            collection: widget.collection,
                            usermodel: user!,
                            coachName: widget.coacheModel!.name,
                            pricesModel: CoachPricesModel(
                                prices: widget.coacheModel!.offlineprices,
                                planDescriptions:
                                    widget.coacheModel!.offlineplanDescriptions,
                                planName: widget.coacheModel!.offlinePlanName,
                                discount: widget.coacheModel!.offlinediscount,
                                points: widget.coacheModel!.offlinepoints,
                                isGroup: widget.coacheModel!.offlineisGroup,
                                reservisionTimes: widget
                                    .coacheModel!.offlineReservisionTimes),
                            serviceProviderId: widget.coacheModel!.userId,
                          ),
                          if (user.state == "1" ||
                              user.uid == widget.coacheModel!.userId)
                            CustomAddCoachPlansButton(
                              coachPricesModel: CoachPricesModel(
                                  prices: widget.coacheModel!.offlineprices,
                                  planDescriptions: widget
                                      .coacheModel!.offlineplanDescriptions,
                                  planName: widget.coacheModel!.offlinePlanName,
                                  discount: widget.coacheModel!.offlinediscount,
                                  points: widget.coacheModel!.offlinepoints,
                                  isGroup: widget.coacheModel!.offlineisGroup,
                                  reservisionTimes: widget
                                      .coacheModel!.offlineReservisionTimes),
                              collection: "offline",
                              coachId: widget.coacheModel!.id,
                            )
                        ],
                      ),
                    ),
                  if (status2 == CoachFilterStatusPricse.main)
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
                                  end: Alignment.bottomCenter),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(size.width * 0.01),
                              child: Center(
                                child: CircleAvatar(
                                    backgroundColor: Pallete.primaryColor,
                                    radius: size.width * 0.2,
                                    backgroundImage: CachedNetworkImageProvider(
                                        widget.coacheModel!.image)),
                              ),
                            )),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        Text(
                          "Coach",
                          style: TextStyle(
                            fontFamily: "Muller",
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.03,
                          ),
                        ),
                        Text(
                          widget.coacheModel!.name,
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
                          widget.coacheModel!.categoriry,
                          style: TextStyle(
                            fontFamily: "Muller",
                            color: Pallete.whiteColor,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                        RatingDisplayWidget(
                            rating: widget.coacheModel!.rating,
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
                                  for (CoachesFilterStatus filterStatus
                                      in CoachesFilterStatus.values)
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (filterStatus ==
                                                CoachesFilterStatus.CV) {
                                              status = CoachesFilterStatus.CV;
                                              _alignment = Alignment.centerLeft;
                                            } else if (filterStatus ==
                                                CoachesFilterStatus.Gallery) {
                                              status =
                                                  CoachesFilterStatus.Gallery;
                                              _alignment =
                                                  Alignment.centerRight;
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.010),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  filterStatus.name,
                                                  style: TextStyle(
                                                      color: Pallete.whiteColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          size.width * 0.03),
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
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.010),
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
                        status == CoachesFilterStatus.Gallery
                            ? InkWell(
                                onLongPress: user!.uid ==
                                        widget.coacheModel!.userId
                                    ? () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateGalleryScreen(
                                                  gymlLocatyionId: "",
                                                  collection: Collections
                                                      .coachCollection,
                                                  gallery: widget
                                                      .coacheModel!.gallery,
                                                  storeId:
                                                      widget.coacheModel!.id,
                                                )))
                                    : () {},
                                child: SizedBox(
                                  height: size.height * 0.3,
                                  width: size.width,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.coacheModel!.gallery.length,
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
                                              horizontal: size.width * 0.03),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                size.width * 0.03),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: widget
                                                  .coacheModel!.gallery[index],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              )
                            : SizedBox(
                                height: size.height * 0.2,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.02),
                                  child: ListView(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Education",
                                            style: TextStyle(
                                              fontFamily: "Muller",
                                              color: const Color.fromARGB(
                                                  255, 250, 220, 52),
                                              fontSize: size.width * 0.037,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            widget.coacheModel!.education,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontFamily: "Muller",
                                              height: size.width * 0.0037,
                                              color: Pallete.whiteColor,
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.width * 0.02,
                                          ),
                                          Text(
                                            "Experience",
                                            style: TextStyle(
                                              fontFamily: "Muller",
                                              color: const Color.fromARGB(
                                                  255, 250, 220, 52),
                                              fontSize: size.width * 0.037,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            widget.coacheModel!.experience,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontFamily: "Muller",
                                              height: size.width * 0.0037,
                                              color: Pallete.whiteColor,
                                              fontSize: size.width * 0.036,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.width * 0.02,
                                          ),
                                          Text(
                                            "Benifits",
                                            style: TextStyle(
                                              fontFamily: "Muller",
                                              color: const Color.fromARGB(
                                                  255, 250, 220, 52),
                                              fontSize: size.width * 0.037,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            widget.coacheModel!.benefits,
                                            style: TextStyle(
                                              fontFamily: "Muller",
                                              height: size.width * 0.0037,
                                              color: Pallete.whiteColor,
                                              fontSize: size.width * 0.036,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
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
                                                    acceptCoach(context)),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            CustomElevatedButton(
                                                size: size,
                                                color: Pallete.redColor,
                                                title: "Refuse",
                                                sizeofwidth: size.width * 0.3,
                                                sizeofhight: size.height * 0.03,
                                                onTap: () => refuseCoach())
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        if (status == CoachesFilterStatus.CV)
                          Container(
                            height: size.height * 0.12,
                            width: size.width * 0.75,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        status2 =
                                            CoachFilterStatusPricse.ONLINE;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 1, 17, 53),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Image.asset(
                                                "assets/page-1/images/live-streaming.png",
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.width * 0.03,
                                            ),
                                            Text(
                                              "ONLINE",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        status2 =
                                            CoachFilterStatusPricse.OFLINE;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 1, 17, 53),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Image.asset(
                                                "assets/page-1/images/coach.png",
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.width * 0.03,
                                            ),
                                            Text(
                                              "OFFLINE",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (widget.coacheModel!.userId == "" &&
                            user!.state == "1")
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => Get.to(() =>
                                      EditCollaboratorStateScreen(
                                          collection: widget.collection,
                                          id: widget.coacheModel!.id)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ),
                      ],
                    )),
                  if (widget.coacheModel!.faceBook != "" &&
                      status2 == CoachFilterStatusPricse.main)
                    Positioned(
                        right: size.width * 0.03,
                        top: size.height * 0.115,
                        child: InkWell(
                          onTap: () => openLink(
                              ref, widget.coacheModel!.faceBook, context),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 800),
                            opacity:
                                status2 == CoachFilterStatusPricse.main ? 1 : 0,
                            child: Image.asset(
                              "assets/page-1/images/facebook-logo.png",
                              width: size.width * 0.08,
                            ),
                          ),
                        )),
                  if (widget.coacheModel!.whatsAppNum != "" &&
                      status2 == CoachFilterStatusPricse.main)
                    Positioned(
                        right: size.width * 0.03,
                        top: size.height * 0.16,
                        child: InkWell(
                          onTap: () => openWhatsApp(
                              ref, widget.coacheModel!.whatsAppNum, context),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 800),
                            opacity:
                                status2 == CoachFilterStatusPricse.main ? 1 : 0,
                            child: Image.asset(
                              "assets/page-1/images/whatsapp.png",
                              width: size.width * 0.08,
                            ),
                          ),
                        )),
                  if (widget.coacheModel!.instgram != "" &&
                      status2 == CoachFilterStatusPricse.main)
                    Positioned(
                        right: size.width * 0.03,
                        top: size.height * 0.2,
                        child: InkWell(
                          onTap: () => openLink(
                              ref, widget.coacheModel!.instgram, context),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 800),
                            opacity:
                                status2 == CoachFilterStatusPricse.main ? 1 : 0,
                            child: Image.asset(
                              "assets/page-1/images/instagram.png",
                              width: size.width * 0.08,
                            ),
                          ),
                        )),
                  if (widget.coacheModel!.dynamicLink != "" &&
                      status2 == CoachFilterStatusPricse.main)
                    Positioned(
                        right: size.width * 0.03,
                        top: size.height * 0.241,
                        child: InkWell(
                          onTap: () => openLink(
                              ref, widget.coacheModel!.dynamicLink, context),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 800),
                            opacity:
                                status2 == CoachFilterStatusPricse.main ? 1 : 0,
                            child: Image.asset(
                              "assets/page-1/images/world-wide-web.png",
                              width: size.width * 0.08,
                            ),
                          ),
                        )),
                  if (widget.coacheModel!.userId != "" &&
                      status2 == CoachFilterStatusPricse.main)
                    ref
                        .watch(getUserDataFutureProvider(
                            widget.coacheModel!.userId))
                        .when(data: (userModel) {
                      return Positioned(
                          left: size.width * 0.05,
                          top: size.height * 0.13,
                          child: InkWell(
                              onTap: () {},
                              child: userModel.points >= 0 &&
                                      userModel.points < 100
                                  ? Image.asset(
                                      "assets/page-1/images/level1.png",
                                      width: size.width * 0.1,
                                    )
                                  : userModel.points >= 100 &&
                                          userModel.points < 400
                                      ? Image.asset(
                                          "assets/page-1/images/level2.png",
                                          width: size.width * 0.1,
                                        )
                                      : userModel.points >= 400 &&
                                              userModel.points < 700
                                          ? Image.asset(
                                              "assets/page-1/images/level3.png",
                                              width: size.width * 0.1,
                                            )
                                          : userModel.points >= 400 &&
                                                  userModel.points < 700
                                              ? Image.asset(
                                                  "assets/page-1/images/level4.png",
                                                  width: size.width * 0.1,
                                                )
                                              : Image.asset(
                                                  "assets/page-1/images/level5.png",
                                                  width: size.width * 0.1,
                                                )));
                    }, error: (error, StackTrace) {
                      print(error);

                      return ErrorText(error: error.toString());
                    }, loading: () {
                      return Center(
                        child: Column(),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
