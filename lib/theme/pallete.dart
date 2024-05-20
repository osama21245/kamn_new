import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

StateNotifierProvider<ThemeNotifier, ThemeData> themeNotiferProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) => ThemeNotifier());

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(165, 164, 164, 1); // sec
  static const lightgreyColor = Color.fromARGB(255, 226, 226, 226);
  static const lightgreyColor2 = Color.fromARGB(255, 204, 204, 204);

  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static const whiteOpacityColor = Color.fromARGB(131, 255, 255, 255);
  static const ratingColor = Color.fromARGB(255, 251, 255, 42);
  static const fontColor = Color(0xff272361);
  static var primaryColor = Color(0xff3a7cbd);
  static var primaryColorTrans = Color.fromARGB(185, 58, 123, 189);
  static var greenButton = Color.fromARGB(227, 66, 209, 109);
  static var redColor = Colors.red.shade500;

  // List<Color>
  static var listofGridient = [
    Color.fromARGB(255, 64, 207, 183),
    Color(0xff3a7cbd),
    Color.fromARGB(255, 58, 89, 189),
    Color(0xff272361)
  ];

  static var listofGridientCard = [
    Color.fromARGB(255, 64, 207, 183),
    Color(0xff3a7cbd),
    Color(0xff272361)
  ];

  static var listofGridientCardPrice = [
    Color.fromARGB(255, 64, 207, 183),
    Color(0xff3a7cbd),
    Color.fromARGB(255, 80, 73, 179),
    Color.fromARGB(255, 104, 37, 192)
  ];

  static var listofGridientCardGymPrices = [
    Color.fromARGB(255, 86, 255, 227),
    Color.fromARGB(255, 34, 224, 193),
    Color.fromARGB(255, 24, 142, 158),
    Color(0xff3a7cbd),
    Color.fromARGB(255, 80, 73, 179),
    Color.fromARGB(255, 65, 37, 192)
  ];

  //Color.fromARGB(255, 129, 92, 214);

  static const badmention = Color(0xff5a7ebb);
  static const volleyball = Color(0xfff03636);
  static const basketball = Color(0xffeb811f);
  static const paddel = Color(0xff532fab);
  static const football = Color(0xff21b846);
  static const tennis = Color(0xff98b229);
  static const swiming = Color.fromARGB(255, 65, 224, 203);

  static const primaryGridentColors = [Color(0x5fffffff), Color(0xff3a7cbd)];
  static const footballGridentColors = [Color(0x5fffffff), Color(0x5f22b947)];
  static const paddelGridentColors = [Color(0x5fffffff), Color(0x5f542fab)];
  static const swimingGridentColors = [
    Color(0x5fffffff),
    Color.fromARGB(255, 65, 224, 203)
  ];
  static const basketballlGridentColors = [
    Color(0x5fffffff),
    Color(0x5fec821f)
  ];
  static const volleyballlGridentColors = [
    Color(0x5fffffff),
    Color(0x5ff03636)
  ];
  static const badmentionGridentColors = [Color(0x5fffffff), Color(0x5f5a7ebb)];
  static const tennisGridentColors = [Color(0x5fffffff), Color(0x5f98b229)];
  static const mersalGridentColors = [
    Color.fromARGB(197, 0, 0, 0),
    Color.fromARGB(125, 122, 46, 46)
  ];

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: primaryColor,
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: blackColor,
        )),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: primaryColor,
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Pallete.darkModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'dark') {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    } else {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
