import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/benefits/widget/medical_details/custom_get_medical_services.dart';
import 'package:kman/featuers/benefits/widget/medical_details/custom_medical_times_card.dart';
import 'package:kman/models/medical_model.dart';
import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/collection_constants.dart';
import '../../../../edit_collaborator_state_screen.dart';
import '../../../../theme/pallete.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../coaches-gyms/controller/coaches-gyms_controller.dart';
import '../../../play/controller/play_controller.dart';
import '../../../play/widget/play/showrating.dart';
import '../../controller/benefits_controller.dart';
import '../../widget/medical_details/custom_add_medical_service_button.dart';
import '../../widget/sports_details/custom_material_button.dart';
import '../../../../core/common/update_gallery_screen.dart';
import '../../../../core/common/update_gallery_screen.dart';

class MedicalDetailsScreen extends ConsumerStatefulWidget {
  final String collection;
  final bool fromAsk;
  final MedicalModel medicalModel;
  const MedicalDetailsScreen(
      {super.key,
      required this.medicalModel,
      required this.fromAsk,
      required this.collection});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MedicalDetailsScreenState();
}

enum MedicalFilterStatus { CV, Gallery, Services }

Alignment _alignment = Alignment.centerLeft;

MedicalFilterStatus status = MedicalFilterStatus.CV;

class _MedicalDetailsScreenState extends ConsumerState<MedicalDetailsScreen> {
  acceptMedical(
    BuildContext context,
  ) {
    ref.watch(benefitsControllerProvider.notifier).setMedicalRequest(
          context,
          widget.medicalModel.image,
          widget.medicalModel.price,
          widget.medicalModel.name,
          widget.medicalModel.experience,
          widget.medicalModel.benefits,
          widget.medicalModel.specialization,
          widget.medicalModel.education,
          widget.medicalModel.discount,
          widget.medicalModel.faceBook,
          widget.medicalModel.region,
          widget.medicalModel.dynamicLink,
          widget.medicalModel.instgram,
          widget.medicalModel.whatAppNum,
          widget.medicalModel.lat,
          widget.medicalModel.long,
          widget.medicalModel.gallery,
        );

    ref
        .watch(benefitsControllerProvider.notifier)
        .deleteMedicalRequest(widget.medicalModel!.id, context);
  }

  refusesMedical() {
    ref
        .watch(benefitsControllerProvider.notifier)
        .deleteMedicalRequest(widget.medicalModel!.id, context);
  }

  @override
  openWhatsApp(String phone, BuildContext context) {
    ref.watch(benefitsControllerProvider.notifier).openWhatsApp(phone, context);
  }

  openLink(String link, BuildContext context) {
    ref.watch(coachesGymsControllerProvider.notifier).openLink(link, context);
  }

  void gpsTracking() {
    ref.watch(playControllerProvider.notifier).gpsTracking(
        widget.medicalModel!.long, widget.medicalModel!.lat, context);
  }

  Widget build(BuildContext context) {
    double finalPrice = widget.medicalModel!.price -
        ((widget.medicalModel!.discount / 100) * widget.medicalModel!.price);
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider);
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          CustomUpperSec(
            size: size,
            color: Pallete.fontColor,
            title: "Doctor",
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
                      height: size.height * 0.1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size.width * 0.02),
                            topRight: Radius.circular(size.width * 0.02)),
                        gradient: LinearGradient(
                            colors: Pallete.listofGridient,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      height: size.height * 0.62,
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
                                backgroundImage: CachedNetworkImageProvider(
                                    widget.medicalModel!.image)),
                          ),
                        )),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    Text(
                      "Doctor",
                      style: TextStyle(
                        fontFamily: "Muller",
                        color: Pallete.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.03,
                      ),
                    ),
                    Text(
                      "${widget.medicalModel!.name}",
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
                      "${widget.medicalModel!.specialization}",
                      style: TextStyle(
                        fontFamily: "Muller",
                        color: Pallete.whiteColor,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    RatingDisplayWidget(
                        rating: widget.medicalModel!.rating,
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
                              for (MedicalFilterStatus filterStatus
                                  in MedicalFilterStatus.values)
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (filterStatus ==
                                            MedicalFilterStatus.CV) {
                                          status = MedicalFilterStatus.CV;
                                          _alignment = Alignment.centerLeft;
                                        } else if (filterStatus ==
                                            MedicalFilterStatus.Services) {
                                          status = MedicalFilterStatus.Services;
                                          _alignment = Alignment.centerRight;
                                        } else if (filterStatus ==
                                            MedicalFilterStatus.Gallery) {
                                          status = MedicalFilterStatus.Gallery;
                                          _alignment = Alignment.center;
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
                                width: size.width * 0.234,
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
                    status == MedicalFilterStatus.Gallery
                        ? InkWell(
                            onLongPress: user!.uid == widget.medicalModel.userId
                                ? () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateGalleryScreen(
                                              gymlLocatyionId: "",
                                              collection:
                                                  Collections.medicalCollection,
                                              gallery:
                                                  widget.medicalModel.gallery,
                                              storeId: widget.medicalModel.id,
                                            )))
                                : () {},
                            child: Container(
                              height: size.height * 0.3,
                              width: size.width,
                              child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      widget.medicalModel!.gallery.length,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
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
                                              .medicalModel!.gallery[index],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        : status == MedicalFilterStatus.Services
                            ? Column(
                                children: [
                                  CustomGetMedicalServices(
                                    medicalModel: widget.medicalModel!,
                                  ),
                                  // if (widget.medicalModel!.userId ==
                                  //         user!.uid ||
                                  //     user!.state == "1")
                                  //   CustomAddMedicalOffersButton(
                                  //     medicalId: widget.medicalModel!.id,
                                  //   )
                                ],
                              )
                            : Container(
                                height: size.height * 0.18,
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
                                              color: Color.fromARGB(
                                                  255, 250, 220, 52),
                                              fontSize: size.width * 0.037,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${widget.medicalModel!.education}",
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
                                              color: Color.fromARGB(
                                                  255, 250, 220, 52),
                                              fontSize: size.width * 0.037,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${widget.medicalModel!.experience}",
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
                                              color: Color.fromARGB(
                                                  255, 250, 220, 52),
                                              fontSize: size.width * 0.037,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${widget.medicalModel!.benefits}",
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
                                                    acceptMedical(context)),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            CustomElevatedButton(
                                                size: size,
                                                color: Pallete.redColor,
                                                title: "Refuse",
                                                sizeofwidth: size.width * 0.3,
                                                sizeofhight: size.height * 0.03,
                                                onTap: () => refusesMedical())
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ),
                    SizedBox(
                      height: size.width * 0.04,
                    ),
                    if (status == MedicalFilterStatus.CV)
                      Container(
                        padding: EdgeInsets.all(size.width * 0.01),
                        color: Color.fromARGB(24, 255, 255, 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.03),
                              child: Text(
                                "Opening Times",
                                style: TextStyle(
                                  fontFamily: "Muller",
                                  color: Color.fromARGB(255, 250, 220, 52),
                                  fontSize: size.width * 0.037,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            CustomMedicalTimesCard(
                                fromDays: widget.medicalModel!.from,
                                toDays: widget.medicalModel!.to,
                                medicalModel: widget.medicalModel!),
                          ],
                        ),
                      ),
                    if (widget.medicalModel!.userId == user!.uid &&
                        status == MedicalFilterStatus.Services)
                      Opacity(
                        opacity: 0.5,
                        child: CustomAddMedicalOffersButton(
                          medicalId: widget.medicalModel!.id,
                        ),
                      )
                  ],
                )),
                Positioned(
                  left: size.width * 0.03,
                  top: size.height * 0.117,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.medicalModel!.discount} %",
                        maxLines: 3,
                        style: TextStyle(
                          wordSpacing: -0.4,
                          fontFamily: "Muller",
                          color: Pallete.whiteColor,
                          fontSize: size.width * 0.047,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Discount",
                        maxLines: 3,
                        style: TextStyle(
                          wordSpacing: -0.4,
                          fontFamily: "Muller",
                          color: Pallete.whiteColor,
                          fontSize: size.width * 0.033,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      if (widget.medicalModel!.userId == "" &&
                          user!.state == "1")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Get.to(() =>
                                  EditCollaboratorStateScreen(
                                      collection: widget.collection,
                                      id: widget.medicalModel!.id)),
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
                ),
                if (widget.medicalModel!.faceBook != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.115,
                      child: InkWell(
                        onTap: () =>
                            openLink(widget.medicalModel!.faceBook, context),
                        child: Image.asset(
                          "assets/page-1/images/facebook-logo.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.medicalModel!.whatAppNum != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.16,
                      child: InkWell(
                        onTap: () => openWhatsApp(
                            widget.medicalModel!.whatAppNum, context),
                        child: Image.asset(
                          "assets/page-1/images/whatsapp.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.medicalModel!.instgram != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.2,
                      child: InkWell(
                        onTap: () =>
                            openLink(widget.medicalModel!.instgram, context),
                        child: Image.asset(
                          "assets/page-1/images/instagram.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.medicalModel!.dynamicLink != "")
                  Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.241,
                      child: InkWell(
                        onTap: () =>
                            openLink(widget.medicalModel!.dynamicLink, context),
                        child: Image.asset(
                          "assets/page-1/images/world-wide-web.png",
                          width: size.width * 0.08,
                        ),
                      )),
                if (widget.medicalModel!.userId != "")
                  ref
                      .watch(getUserDataFutureProvider(
                          widget.medicalModel!.userId))
                      .when(data: (userModel) {
                    return Positioned(
                        left: size.width * 0.05,
                        top: size.height * 0.166,
                        child: InkWell(
                            onTap: () {},
                            child:
                                userModel.points >= 0 && userModel.points < 100
                                    ? Image.asset(
                                        "assets/page-1/images/level1.png",
                                        width: size.width * 0.1,
                                      )
                                    : userModel.points >= 100 &&
                                            userModel!.points < 400
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
      )),
    );
  }
}
