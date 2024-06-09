import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/models/gym_locations_model.dart';
import '../../../../../HandlingDataView.dart';
import '../../../../../core/common/textfield.dart';
import '../../../../../core/providers/valid.dart';
import '../../../../../theme/pallete.dart';
import '../../../../core/class/alex_regions_lists.dart';
import '../../../auth/widget/finsh/custom_finish_middlesec.dart';

class UpdateGymLocationScreen extends ConsumerStatefulWidget {
  final GymLocationsModel gymModel;
  const UpdateGymLocationScreen({super.key, required this.gymModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateGymLocationScreenState();
}

class _UpdateGymLocationScreenState
    extends ConsumerState<UpdateGymLocationScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? fullname;

  TextEditingController? whatssAppnum;
  TextEditingController? lat;
  TextEditingController? long;
  TextEditingController? address;
  TextEditingController? instgramLink;
  TextEditingController? facebookLink;
  TextEditingController? dynamicLink;
  String region = "Miami";
  String gym = "Mix";
  @override
  void initState() {
    facebookLink = TextEditingController(text: widget.gymModel.facebook);
    instgramLink = TextEditingController(text: widget.gymModel.instgram);
    whatssAppnum = TextEditingController(text: widget.gymModel.whatsAppNum);
    dynamicLink = TextEditingController(text: widget.gymModel.dynamicLink);
    fullname = TextEditingController(text: widget.gymModel.name);
    address = TextEditingController(text: widget.gymModel.address.toString());
    lat = TextEditingController(text: widget.gymModel.lat.toString());
    long = TextEditingController(text: widget.gymModel.long.toString());
    super.initState();
  }

  @override
  void dispose() {
    dynamicLink!.dispose();
    facebookLink!.dispose();
    whatssAppnum!.dispose();
    lat!.dispose();
    long!.dispose();
    address!.dispose();
    instgramLink!.dispose();
    fullname!.dispose();

    super.dispose();
  }

  updateGymLocation(WidgetRef ref) {
    var Formdata = formstate.currentState;
    if (Formdata!.validate()) {
      GymLocationsModel gymLocationsModel = GymLocationsModel(
        id: widget.gymModel.id,
        name: fullname!.text,
        userId: widget.gymModel.userId,
        image: widget.gymModel.image,
        rating: 0,
        facebook: facebookLink!.text,
        instgram: instgramLink!.text,
        whatsAppNum: whatssAppnum!.text,
        dynamicLink: dynamicLink!.text,
        address: address!.text,
        city: widget.gymModel.city,
        ismix: gym == "Mix" ? true : false,
        lat: double.parse(lat!.text),
        long: double.parse(long!.text),
        mainGymId: widget.gymModel.mainGymId,
        region: region,
        gallery: widget.gymModel.gallery,
        fitnessisMix: widget.gymModel.fitnessisMix,
        fitnessisSpecial: widget.gymModel.fitnessisSpecial,
        fitnessplanTime: widget.gymModel.fitnessplanTime,
        offersSpecial: widget.gymModel.offersSpecial,
        offersisMix: widget.gymModel.offersisMix,
        offersplanTime: widget.gymModel.offersplanTime,
        servicesdisMix: widget.gymModel.servicesdisMix,
        servicesisSpecial: widget.gymModel.servicesisSpecial,
        weightLiftisMix: widget.gymModel.weightLiftisMix,
        weightLiftisSpecial: widget.gymModel.weightLiftisSpecial,
        offerspoints: widget.gymModel.offerspoints,
        offersprices: widget.gymModel.offersprices,
        offersplanDescriptions: widget.gymModel.offersplanDescriptions,
        offersPlanName: widget.gymModel.offersPlanName,
        offersdiscount: widget.gymModel.offersdiscount,
        fitnesspoints: widget.gymModel.fitnesspoints,
        fitnessprices: widget.gymModel.fitnessprices,
        fitnessplanDescriptions: widget.gymModel.fitnessplanDescriptions,
        fitnessplanName: widget.gymModel.fitnessplanName,
        fitnessdiscount: widget.gymModel.fitnessdiscount,
        weightLiftpoints: widget.gymModel.weightLiftpoints,
        weightLiftprices: widget.gymModel.weightLiftprices,
        weightLiftplanDescriptions: widget.gymModel.weightLiftplanDescriptions,
        weightLiftplanName: widget.gymModel.weightLiftplanName,
        weightLiftdiscount: widget.gymModel.weightLiftdiscount,
        weightLiftplanTime: widget.gymModel.weightLiftplanTime,
        servicespoints: widget.gymModel.servicespoints,
        servicesprices: widget.gymModel.servicesprices,
        servicesplanDescriptions: widget.gymModel.servicesplanDescriptions,
        servicesplanName: widget.gymModel.servicesplanName,
        servicesdiscount: widget.gymModel.servicesdiscount,
        servicesplanTime: widget.gymModel.servicesplanTime,
      );
      // may cause Erorr null check because logo!
      ref
          .watch(coachesGymsControllerProvider.notifier)
          .updategymLocation(gymLocationsModel, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(coachesGymsControllerProvider);
    List<String> gymList = [
      'Mix',
      'Separeted',
    ];
    return Scaffold(
      body: Form(
        key: formstate,
        child: SafeArea(
            child: HandlingDataView(
          statusRequest: statusRequest,
          widget: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.07, vertical: size.height * 0.05),
            child: ListView(
              children: [
                Text(
                  "Finish Gym Setup",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Pallete.fontColor,
                      fontFamily: "Muller",
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                Text(
                  "Please complete the following information to \n Fisnsh Your Gym Setup",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Pallete.greyColor,
                      fontFamily: "Muller",
                      fontSize: size.width * 0.037,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: size.height * 0.016,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 1, 500, "");
                  },
                  name: "lat",
                  controller: lat!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 1, 500, "");
                  },
                  name: "long",
                  controller: long!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 1, 500, "");
                  },
                  name: "address",
                  controller: address!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  validator: (val) {
                    return validinput(val!, 4, 500, "");
                  },
                  name: "Full Name",
                  controller: fullname!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                TextFiled(
                  name: "whatAppNumber",
                  controller: whatssAppnum!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.016,
                ),
                TextFiled(
                  name: "instgramLink",
                  controller: instgramLink!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.016,
                ),
                TextFiled(
                  name: "faceBookLink",
                  controller: facebookLink!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.016,
                ),
                TextFiled(
                  name: "dynamicLink",
                  controller: dynamicLink!,
                  color: Pallete.lightgreyColor2,
                ),
                SizedBox(
                  height: size.height * 0.016,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Pallete.fontColor),
                      borderRadius: BorderRadius.circular(size.width * 0.02)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: DropdownButton(
                      underline: Text(""),
                      style: TextStyle(
                          color: Pallete.lightgreyColor2,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.037,
                          fontWeight: FontWeight.w500),
                      isExpanded: true,
                      value: gym,
                      focusColor: const Color.fromARGB(0, 255, 192, 192),
                      items: gymList.map((gen) {
                        return DropdownMenuItem(
                          value: gen,
                          child: Text(gen),
                          onTap: () {
                            if (gen == gymList[0]) {
                              gym = gymList[0];
                            } else if (gen == gymList[1]) {
                              gym = gymList[1];
                            }
                            setState(() {});
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          gym = value!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Pallete.fontColor),
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: DropdownButton(
                      underline: Text(""),
                      style: TextStyle(
                        color: Pallete.lightgreyColor2,
                        fontFamily: "Muller",
                        fontSize: size.width * 0.037,
                        fontWeight: FontWeight.w500,
                      ),
                      isExpanded: true,
                      value: region,
                      focusColor: const Color.fromARGB(0, 255, 192, 192),
                      items: alexandriaRegionsForAdd.map((region) {
                        return DropdownMenuItem(
                          value: region,
                          child: Text(region),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          region = value!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.height * 0.02, bottom: size.height * 0.02),
                  child: CustomFinishMiddleSec(
                      color: Pallete.fontColor,
                      collection: "Finish Submet",
                      size: size),
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: ElevatedButton(
                    onPressed: () => updateGymLocation(ref),
                    child: Text(
                      'Finish',
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontFamily: "Muller",
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        fixedSize: Size(size.width, size.height * 0.06),
                        backgroundColor: Pallete.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02))),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
