import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/function/goTo.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/coaches-gyms/widget/locations/custom_get_locations.dart';
import '../../../../HandlingDataView.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/providers/checkInternet.dart';
import '../../../../models/gym_model.dart';
import '../../../../theme/pallete.dart';
import '../../../user/controller/user_controller.dart';
import '../../controller/coaches-gyms_controller.dart';
import 'gym_location_add_screen.dart';
import 'refuse_gym_request.dart';

class GymLocationsScreen extends ConsumerStatefulWidget {
  final GymModel gymModel;
  final String collection;
  final bool fromAsk;
  const GymLocationsScreen(
      {super.key,
      required this.gymModel,
      required this.collection,
      required this.fromAsk});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GymLocationsScreenState();
}

class _GymLocationsScreenState extends ConsumerState<GymLocationsScreen> {
  acceptGym(
    BuildContext context,
  ) {
    ref.watch(coachesGymsControllerProvider.notifier).setGymsRequests(context,
        widget.gymModel.image, widget.gymModel.name, widget.gymModel.ismix);

    // send message to user
    ref.watch(userControllerProvider.notifier).sendInboxToUser(
        title: "Congratulations",
        description: "Your service has been added successfully to kamn",
        imageFile: null,
        userId: widget.gymModel.userId,
        defImage: true,
        context: context);
//update user state

    ref
        .watch(authControllerProvider.notifier)
        .updateUserServiceStatus("5", widget.gymModel.userId, context);

    ref
        .watch(coachesGymsControllerProvider.notifier)
        .deletegymRequest(widget.gymModel.id, context);
  }

  StatusRequest statusRequest = StatusRequest.success;

  checkinternet() async {
    setState(() {
      statusRequest = StatusRequest.loading2;
    });

    if (await checkInternet()) {
      setState(() {
        statusRequest = StatusRequest.success;
      });
    } else {
      setState(() {
        statusRequest = StatusRequest.offlinefalire2;
      });
    }
  }

  @override
  void initState() {
    checkinternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(usersProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton:
          user!.state == "1" || widget.gymModel.userId == user.uid
              ? FloatingActionButton(
                  onPressed: () => Get.to(() => AddgymsLocationsScreen(
                        image: widget.gymModel.image,
                        gymId: widget.gymModel.id,
                      )),
                  child: Icon(Icons.add),
                )
              : null,
      body: widget.fromAsk
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                      size: size,
                      color: Pallete.greenButton,
                      title: "Accept",
                      sizeofwidth: size.width * 0.35,
                      sizeofhight: size.height * 0.03,
                      onTap: () => acceptGym(context)),
                  CustomElevatedButton(
                      size: size,
                      color: Pallete.redColor,
                      title: "Refuse",
                      sizeofwidth: size.width * 0.35,
                      sizeofhight: size.height * 0.03,
                      onTap: () => goToScreen(context,
                          RefuseGymRequestScreen(gymModel: widget.gymModel)))
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  CustomUpperSec(
                    size: size,
                    color: Pallete.fontColor,
                    title: "Branches",
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
                  HandlingDataView(
                      statusRequest: statusRequest,
                      widget: CustomGetLocations(
                        gymId: widget.gymModel.id,
                        image: widget.gymModel.image,
                      ))
                ],
              ),
            ),
    );
  }
}
