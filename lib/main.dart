import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/class/crud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'core/constants/localization/changelocal.dart';
import 'core/constants/services/services.dart';
import 'routes.dart';
import 'theme/pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyDiNbvFUa6CnxtNpBYraqjO1NiXiYldhbg",
      //     authDomain: "kman-ab86f.firebaseapp.com",
      //     projectId: "kman-ab86f",
      //     storageBucket: "kman-ab86f.appspot.com",
      //     messagingSenderId: "1036256826353",
      //     appId: "1:1036256826353:web:b66b9b0666f4f806f26a50",
      //     measurementId: "G-WEXFG4Q7ES"),
      );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await initialServices();

  runApp(ProviderScope(child: MyApp()));
  Get.put(Crud());
}

class MyApp extends ConsumerStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());

    return GetMaterialApp(
      theme: ref.watch(themeNotiferProvider),
      debugShowCheckedModeBanner: false,
      title: 'KAMN',
      // navigatorObservers: [
      //   FirebaseMessagingObserver(),
      // ],
      getPages: routes,
    );
  }
}
