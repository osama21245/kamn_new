import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:kman/featuers/play/screens/refuse_ground_request.dart';
import 'package:kman/featuers/play/screens/update_ground_screen.dart';
import 'package:kman/featuers/play/widget/ground_details/custom_ground_middlesec.dart';
import 'package:kman/featuers/play/widget/play/custom_play_grident.dart';
import 'package:kman/featuers/user/controller/user_controller.dart';
import 'package:kman/models/grounds_model.dart';
import '../../../core/common/custom_elevated_button.dart';
import '../../../core/common/custom_icon_uppersec.dart';
import '../../../core/common/custom_uppersec.dart';
import '../../../core/function/goTo.dart';
import '../../../edit_collaborator_state_screen.dart';
import '../../../theme/pallete.dart';
import '../widget/ground_details/custom_ground_body.dart';
import 'myplay_screen.dart';

// ignore: must_be_immutable
class GroundDetailsScreen extends ConsumerWidget {
  final Color color;
  final Size size;
  final bool fromAsk;
  final List<Color> backgroundColor;
  final String collection;
  final GroundModel groundModel;
  const GroundDetailsScreen(
      {Key? key,
      required this.color,
      required this.fromAsk,
      required this.size,
      required this.backgroundColor,
      required this.collection,
      required this.groundModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    acceptGround(
      BuildContext context,
    ) {
      ref.watch(playControllerProvider.notifier).setGroundRequest(
          groundModel.long,
          groundModel.lat,
          groundModel.address,
          groundModel.price,
          groundModel.name,
          groundModel.groundnumber,
          groundModel.futuers,
          groundModel.image,
          context,
          collection,
          groundModel.groundPlayersNum,
          groundModel.city,
          groundModel.region);

      ref
          .watch(playControllerProvider.notifier)
          .deleteGroundRequest(groundModel.id, collection, context);

      //send message to user
      ref.watch(userControllerProvider.notifier).sendInboxToUser(
          title: "Congratulations",
          description: "Your service has been added successfully to kamn",
          imageFile: null,
          userId: groundModel.groundOwnerId,
          defImage: true,
          context: context);

      //update user state

      ref
          .watch(authControllerProvider.notifier)
          .updateUserServiceStatus("9", groundModel.groundOwnerId, context);
    }

    final user = ref.watch(usersProvider);
    return Scaffold(
      body: SafeArea(
        child: CustomGridentBackground(
          colors: backgroundColor,
          child: ListView(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: user!.uid == groundModel.groundOwnerId
                        ? () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                GroundOwnerReservisionsScreen()))
                        : () {},
                    child: groundModel.groundOwnerId == user.uid ||
                            user.state == "1"
                        ? CustomIconUpperSec(
                            size: size,
                            color: Pallete.fontColor,
                            title: "Sport",
                            onTapAction: () {
                              goToScreen(
                                  context,
                                  UpdateGroundScreen(
                                    groundMdoel: groundModel,
                                    collection: collection,
                                  ));
                            },
                          )
                        : CustomUpperSec(
                            color: color,
                            size: size,
                            title: "Play",
                          ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      if (user.state == "1") {
                        Get.to(() => EditCollaboratorStateScreen(
                            collection: collection, id: groundModel.id));
                      }
                    },
                    child: CustomGroundMiddleSec(
                        color: color,
                        size: size,
                        collection: collection,
                        title:
                            groundModel.groundOwnerId == "" && user.state == "1"
                                ? "Not active"
                                : groundModel.name,
                        rating: groundModel.rating),
                  ),
                  CustomGroundBody(
                      collection: collection,
                      color: color,
                      groundModel: groundModel,
                      size: size),
                ],
              ),
              if (fromAsk)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                        size: size,
                        color: Pallete.greenButton,
                        title: "Accept",
                        sizeofwidth: size.width * 0.3,
                        sizeofhight: size.height * 0.03,
                        onTap: () => acceptGround(context)),
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
                            RefuseGroundRequestScreen(
                                groundModel: groundModel,
                                collection: collection)))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
