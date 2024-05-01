import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';

import '../constants/constants.dart';

class CustomGoogleMaps extends ConsumerStatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends ConsumerState<CustomGoogleMaps> {
  GoogleMapController? gmc;

  @override
  Widget build(BuildContext context) {
    List<Marker> location = [];
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: Constants.kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        gmc = controller;
      },
      onTap: (LatLng lating) {
        ref.read(benefitsControllerProvider.notifier).lat = lating.latitude;
        ref.read(benefitsControllerProvider.notifier).long = lating.longitude;
        location.add(Marker(
            markerId: MarkerId("1"),
            position: LatLng(ref.read(benefitsControllerProvider.notifier).lat,
                ref.read(benefitsControllerProvider.notifier).long)));
        setState(() {});
      },
      markers: location.toSet(),
    );
  }
}
