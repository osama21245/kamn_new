// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:kman/core/common/custom_elevated_button.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/core/providers/utils.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:kman/theme/pallete.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../../featuers/benefits/controller/benefits_controller.dart';

class CustomGoogleMaps extends ConsumerStatefulWidget {
  final String collection;
  const CustomGoogleMaps({super.key, required this.collection});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends ConsumerState<CustomGoogleMaps> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomElevatedButton(
        size: size,
        color: Pallete.fontColor,
        title: "Location",
        sizeofwidth: size.width,
        sizeofhight: size.height * 0.06,
        onTap: () {
          showBottomSheet(
              context: context,
              builder: (context) {
                return OpenStreetMapSearchAndPick(onPicked: (pickedData) {
                  if (widget.collection == Collections.sportsCollection ||
                      widget.collection == Collections.nutritionCollection ||
                      widget.collection == Collections.medicalCollection) {
                    ref.read(benefitsControllerProvider.notifier).lat =
                        pickedData.latLong.latitude;
                    ref.read(benefitsControllerProvider.notifier).long =
                        pickedData.latLong.longitude;
                  } else if (widget.collection == Collections.gymCollection) {
                    ref.read(coachesGymsControllerProvider.notifier).lat =
                        pickedData.latLong.latitude;
                    ref.read(coachesGymsControllerProvider.notifier).long =
                        pickedData.latLong.longitude;
                  } else {
                    ref.read(playControllerProvider.notifier).lat =
                        pickedData.latLong.latitude;
                    ref.read(playControllerProvider.notifier).long =
                        pickedData.latLong.longitude;
                  }

                  print(ref.read(benefitsControllerProvider.notifier).lat);
                  showSnackBar("Your location has been added", context);
                });
              });
        });
  }
}
