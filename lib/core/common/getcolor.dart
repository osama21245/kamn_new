import 'package:flutter/material.dart';

import '../../theme/pallete.dart';

getColor(String collection) {
  final color = collection == "Football"
      ? Pallete.football
      : collection == "Basketball"
          ? Pallete.basketball
          : collection == "Volleyball"
              ? Pallete.volleyball
              : collection == "Tennis"
                  ? Pallete.tennis
                  : collection == "Badminton"
                      ? Pallete.badmention
                      : collection == "Padel"
                          ? Pallete.paddel
                          :collection == "Swiming" ? Pallete.swiming : Colors.black;

  return color;
}

getGrediantColors(String collection) {
  List<Color> backGroundGridentColor = collection == "Football"
      ? Pallete.footballGridentColors
      : collection == "Basketball"
          ? Pallete.basketballlGridentColors
          : collection == "Volleyball"
              ? Pallete.volleyballlGridentColors
              : collection == "Tennis"
                  ? Pallete.tennisGridentColors
                  : collection == "Badminton"
                      ? Pallete.badmentionGridentColors
                      : collection == "Padel"
                          ?  Pallete.paddelGridentColors
                          : collection == "Swiming" ? Pallete.swimingGridentColors : Pallete.basketballlGridentColors;
  return backGroundGridentColor;
}
