import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/function/awesome_dialog.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/models/gym_locations_model.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/common/update_gallery_screen.dart';
import '../../../../core/constants/collection_constants.dart';
import '../../../../edit_collaborator_state_screen.dart';
import '../../../../models/prices_model copy.dart';
import '../../../../theme/pallete.dart';
import '../../../play/controller/play_controller.dart';
import '../../../play/widget/play/showrating.dart';
import '../../controller/coaches-gyms_controller.dart';
import '../../widget/gyms_details/custom_add_gymplans_button.dart';
import '../../widget/gyms_details/custom_gym_uppersec.dart';
import '../../widget/gyms_details/gym_prices_card.dart';

class GymDetailsScreen extends ConsumerStatefulWidget {
  final String collection;
  final GymLocationsModel gymModel;
  const GymDetailsScreen({
    super.key,
    required this.gymModel,
    required this.collection,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GymDetailsScreenState();
}

enum GymsFilterStatus {
  Main,
  Fitness,
  Weight_Lifting,
  Offers,
  Servics,
  Gallery
}

Alignment _alignment = Alignment.centerLeft;

GymsFilterStatus status = GymsFilterStatus.Main;

class _GymDetailsScreenState extends ConsumerState<GymDetailsScreen> {
  openLink(WidgetRef ref, String link, BuildContext context) {
    ref.watch(coachesGymsControllerProvider.notifier).openLink(link, context);
  }

  openWhatsApp(WidgetRef ref, String phone, BuildContext context) {
    ref
        .watch(coachesGymsControllerProvider.notifier)
        .openWhatsApp(phone, context);
  }

  void gpsTracking(Size size) {
    if (widget.gymModel.lat == 0.0 && widget.gymModel.long == 0.0) {
      showAwesomeDialog(context, "This store\n has no location added", size);
    } else {
      ref
          .watch(playControllerProvider.notifier)
          .gpsTracking(widget.gymModel.long, widget.gymModel.lat, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(usersProvider);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          CustomGymUpperSec(
            size: size,
            color: Pallete.fontColor,
            title: "GYM",
            onTapAction: () => gpsTracking(size),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          const Divider(
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
                        height: status == GymsFilterStatus.Main
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
                      height: status == GymsFilterStatus.Main
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
                            color: Pallete.fontColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(size.width * 0.02),
                                bottomRight:
                                    Radius.circular(size.width * 0.02))),
                        height: size.height * 0.08,
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03),
                          child: Row(
                            children: [
                              status == GymsFilterStatus.Main
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          status = GymsFilterStatus.Gallery;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.photo_filter_rounded,
                                        color: Pallete.whiteColor,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          status = GymsFilterStatus.Main;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Pallete.whiteColor,
                                      )),
                              SizedBox(
                                width: status == GymsFilterStatus.Weight_Lifting
                                    ? size.width * 0.15
                                    : size.width * 0.23,
                              ),
                              Text(
                                "${status.name}",
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

                //
                if (status == GymsFilterStatus.Fitness)
                  Positioned.fill(
                    child: Column(
                      children: [
                        GymPricesCard(
                          gymId: widget.gymModel.mainGymId,
                          gymName: widget.gymModel.name,
                          pricesModel: GymPricesModel(
                              prices: widget.gymModel.fitnessprices,
                              planDescriptions:
                                  widget.gymModel.fitnessplanDescriptions,
                              planName: widget.gymModel.fitnessplanName,
                              discount: widget.gymModel.fitnessdiscount,
                              points: widget.gymModel.fitnesspoints,
                              ismix: widget.gymModel.fitnessisMix,
                              planTime: widget.gymModel.fitnessplanTime),
                          serviceProviderId: widget.gymModel.userId,
                        ),
                        if (user!.state == "1")
                          CustomAddGymPlansButton(
                            gymPricesModel: GymPricesModel(
                                prices: widget.gymModel.fitnessprices,
                                planDescriptions:
                                    widget.gymModel.fitnessplanDescriptions,
                                planName: widget.gymModel.fitnessplanName,
                                discount: widget.gymModel.fitnessdiscount,
                                points: widget.gymModel.fitnesspoints,
                                ismix: widget.gymModel.fitnessisMix,
                                planTime: widget.gymModel.fitnessplanTime),
                            collection: "fitness",
                            gymLocationId: widget.gymModel.id,
                            gymId: widget.gymModel.mainGymId,
                          )
                      ],
                    ),
                  ),
                if (status == GymsFilterStatus.Weight_Lifting)
                  Positioned.fill(
                    child: Column(
                      children: [
                        GymPricesCard(
                          gymId: widget.gymModel.mainGymId,
                          gymName: widget.gymModel.name,
                          pricesModel: GymPricesModel(
                              prices: widget.gymModel.weightLiftprices,
                              planDescriptions:
                                  widget.gymModel.weightLiftplanDescriptions,
                              planName: widget.gymModel.weightLiftplanName,
                              discount: widget.gymModel.weightLiftdiscount,
                              points: widget.gymModel.weightLiftpoints,
                              ismix: widget.gymModel.weightLiftisMix,
                              planTime: widget.gymModel.weightLiftplanTime),
                          serviceProviderId: widget.gymModel.userId,
                        ),
                        if (user!.state == "1")
                          CustomAddGymPlansButton(
                            gymPricesModel: GymPricesModel(
                                prices: widget.gymModel.weightLiftprices,
                                planDescriptions:
                                    widget.gymModel.weightLiftplanDescriptions,
                                planName: widget.gymModel.weightLiftplanName,
                                discount: widget.gymModel.weightLiftdiscount,
                                points: widget.gymModel.weightLiftpoints,
                                ismix: widget.gymModel.weightLiftisMix,
                                planTime: widget.gymModel.weightLiftplanTime),
                            collection: "weightLift",
                            gymLocationId: widget.gymModel.id,
                            gymId: widget.gymModel.mainGymId,
                          )
                      ],
                    ),
                  ),
                if (status == GymsFilterStatus.Offers)
                  Positioned.fill(
                    child: Column(
                      children: [
                        GymPricesCard(
                          gymId: widget.gymModel.mainGymId,
                          gymName: widget.gymModel.name,
                          pricesModel: GymPricesModel(
                              prices: widget.gymModel.offersprices,
                              planDescriptions:
                                  widget.gymModel.offersplanDescriptions,
                              planName: widget.gymModel.offersPlanName,
                              discount: widget.gymModel.offersdiscount,
                              points: widget.gymModel.offerspoints,
                              ismix: widget.gymModel.offersisMix,
                              planTime: widget.gymModel.offersplanTime),
                          serviceProviderId: widget.gymModel.userId,
                        ),
                        if (user!.state == "1")
                          CustomAddGymPlansButton(
                            gymPricesModel: GymPricesModel(
                                prices: widget.gymModel.offersprices,
                                planDescriptions:
                                    widget.gymModel.offersplanDescriptions,
                                planName: widget.gymModel.offersPlanName,
                                discount: widget.gymModel.offersdiscount,
                                points: widget.gymModel.offerspoints,
                                ismix: widget.gymModel.offersisMix,
                                planTime: widget.gymModel.offersplanTime),
                            collection: "offers",
                            gymLocationId: widget.gymModel.id,
                            gymId: widget.gymModel.mainGymId,
                          )
                      ],
                    ),
                  ),
                if (status == GymsFilterStatus.Servics)
                  Positioned.fill(
                    child: Column(
                      children: [
                        GymPricesCard(
                          gymId: widget.gymModel.mainGymId,
                          gymName: widget.gymModel.name,
                          pricesModel: GymPricesModel(
                              prices: widget.gymModel.servicesprices,
                              planDescriptions:
                                  widget.gymModel.servicesplanDescriptions,
                              planName: widget.gymModel.servicesplanName,
                              discount: widget.gymModel.servicesdiscount,
                              points: widget.gymModel.servicespoints,
                              ismix: widget.gymModel.servicesdisMix,
                              planTime: widget.gymModel.servicesplanTime),
                          serviceProviderId: widget.gymModel.userId,
                        ),
                        if (user!.state == "1")
                          CustomAddGymPlansButton(
                            gymPricesModel: GymPricesModel(
                                prices: widget.gymModel.servicesprices,
                                planDescriptions:
                                    widget.gymModel.servicesplanDescriptions,
                                planName: widget.gymModel.servicesplanName,
                                discount: widget.gymModel.servicesdiscount,
                                points: widget.gymModel.servicespoints,
                                ismix: widget.gymModel.servicesdisMix,
                                planTime: widget.gymModel.servicesplanTime),
                            collection: "services",
                            gymLocationId: widget.gymModel.id,
                            gymId: widget.gymModel.mainGymId,
                          )
                      ],
                    ),
                  ),
                if (status == GymsFilterStatus.Main ||
                    status == GymsFilterStatus.Gallery)
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
                                    backgroundImage: CachedNetworkImageProvider(
                                        widget.gymModel.image)),
                              ),
                            )),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        Text(
                          "${status == GymsFilterStatus.Main ? widget.gymModel.name : status.name}",
                          style: TextStyle(
                              fontFamily: "Muller",
                              color: Pallete.whiteColor,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: size.width * 0.008,
                        ),
                        RatingDisplayWidget(
                            rating: widget.gymModel.rating,
                            color: Pallete.ratingColor,
                            size: size.width * 0.05),
                        SizedBox(
                          height: size.height * 0.018,
                        ),
                        status == GymsFilterStatus.Gallery
                            ? InkWell(
                                onLongPress: user!.uid == widget.gymModel.userId
                                    ? () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateGalleryScreen(
                                                  gymlLocatyionId:
                                                      widget.gymModel.id,
                                                  collection:
                                                      Collections.gymCollection,
                                                  gallery:
                                                      widget.gymModel.gallery,
                                                  storeId:
                                                      widget.gymModel.mainGymId,
                                                )))
                                    : () {},
                                child: SizedBox(
                                  height: size.height * 0.3,
                                  width: size.width * 0.77,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.gymModel.gallery.length,
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
                                                  .gymModel.gallery[index],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              )
                            : SizedBox(
                                height: size.height * 0.35,
                                width: size.width * 0.75,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  status =
                                                      GymsFilterStatus.Servics;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 1, 17, 53),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Image.asset(
                                                          "assets/page-1/images/public-service.png",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.width * 0.03,
                                                      ),
                                                      const Text(
                                                        "Services",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                  status =
                                                      GymsFilterStatus.Offers;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 1, 17, 53),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      size.width * 0.05),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Image.asset(
                                                          "assets/page-1/images/special-offer.png",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.width * 0.03,
                                                      ),
                                                      Text(
                                                        "Offers",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.width * 0.02,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  status =
                                                      GymsFilterStatus.Fitness;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 1, 17, 53),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      size.width * 0.05),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Image.asset(
                                                          "assets/page-1/images/vr-fitness.png",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.width * 0.03,
                                                      ),
                                                      Text(
                                                        "Fitness",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                  status = GymsFilterStatus
                                                      .Weight_Lifting;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 1, 17, 53),
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      size.width * 0.05),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Image.asset(
                                                          "assets/page-1/images/weight-lifting.png",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.width * 0.03,
                                                      ),
                                                      const Text(
                                                        "Weight Lifting",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                if (widget.gymModel.facebook != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.115,
                      child: InkWell(
                        onTap: () =>
                            openLink(ref, widget.gymModel.facebook, context),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 800),
                          opacity: status == GymsFilterStatus.Main ? 1 : 0,
                          child: Image.asset(
                            "assets/page-1/images/facebook-logo.png",
                            width: size.width * 0.08,
                          ),
                        ),
                      )),
                if (widget.gymModel.whatsAppNum != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.16,
                      child: InkWell(
                        onTap: () => openWhatsApp(
                            ref, widget.gymModel.whatsAppNum, context),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 800),
                          opacity: status == GymsFilterStatus.Main ? 1 : 0,
                          child: Image.asset(
                            "assets/page-1/images/whatsapp.png",
                            width: size.width * 0.08,
                          ),
                        ),
                      )),
                if (widget.gymModel.instgram != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.2,
                      child: InkWell(
                        onTap: () =>
                            openLink(ref, widget.gymModel.instgram, context),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 800),
                          opacity: status == GymsFilterStatus.Main ? 1 : 0,
                          child: Image.asset(
                            "assets/page-1/images/instagram.png",
                            width: size.width * 0.08,
                          ),
                        ),
                      )),
                if (widget.gymModel.dynamicLink != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.241,
                      child: InkWell(
                        onTap: () =>
                            openLink(ref, widget.gymModel.dynamicLink, context),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 800),
                          opacity: status == GymsFilterStatus.Main ? 1 : 0,
                          child: Image.asset(
                            "assets/page-1/images/world-wide-web.png",
                            width: size.width * 0.08,
                          ),
                        ),
                      )),
                if (widget.gymModel.userId == "" && user!.state == "1")
                  Positioned(
                    left: size.width * 0.03,
                    bottom: size.height * 0.117,
                    child: InkWell(
                      onTap: () => Get.to(() => EditCollaboratorStateScreen(
                          collection: widget.collection,
                          id: widget.gymModel.id)),
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
                  )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
