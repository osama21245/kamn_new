// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:kman/HandlingDataView.dart';
// import 'package:kman/core/class/statusrequest.dart';
// import 'package:kman/core/common/custom_uppersec.dart';
// import 'package:kman/core/common/error_text.dart';
// import 'package:kman/core/common/prices_card.dart';
// import 'package:kman/featuers/auth/controller/auth_controller.dart';
// import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
// import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';

// import 'package:kman/theme/pallete.dart';
// import 'package:lottie/lottie.dart';

// import 'core/common/textfield.dart';
// import 'core/constants/imgaeasset.dart';

// class GetPricesScreen extends ConsumerStatefulWidget {
//   String collection;
//   String Id;
//   String serviceProviderId;
//   GetPricesScreen(
//       {super.key,
//       required this.collection,
//       required this.Id,
//       required this.serviceProviderId});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _GetPricesScreenState();
// }

// class _GetPricesScreenState extends ConsumerState<GetPricesScreen> {
//   TextEditingController? price;
//   TextEditingController? plan;
//   TextEditingController? description;
//   TextEditingController? discount;
//   TextEditingController? points;
//   @override
//   void initState() {
//     price = TextEditingController();
//     plan = TextEditingController();
//     description = TextEditingController();
//     discount = TextEditingController();
//     points = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     price!.dispose();
//     plan!.dispose();
//     description!.dispose();
//     discount!.dispose();
//     points!.dispose();
//     QrCode = "";
//     super.dispose();
//   }

//   updatePricesBenefits(
//       List<dynamic> prices,
//       List<dynamic> pricePlan,
//       List<dynamic> descriptionPlan,
//       List<dynamic> discount,
//       List<dynamic> points) {
//     ref.watch(benefitsControllerProvider.notifier).updatePrices(
//         widget.collection,
//         widget.Id,
//         prices,
//         pricePlan,
//         descriptionPlan,
//         discount,
//         points,
//         context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     StatusRequest statusRequest = ref.watch(benefitsControllerProvider);

//     final user = ref.watch(usersProvider);
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//           child: HandlingDataView(
//               statusRequest: statusRequest,
//               widget: Column(
//                 children: [
//                   CustomUpperSec(
//                       size: size, color: Pallete.fontColor, title: "Prices"),
//                   Divider(
//                     thickness: 3,
//                     color: Pallete.fontColor,
//                   ),
//                   ref
//                       .watch(widget.collection == "medical"
//                           ? getMedicalPricesProvider(widget.Id)
//                           : widget.collection == "coach"
//                               ? getCoachesPricesProvider(widget.Id)
//                               : widget.collection == "gym"
//                                   ? getGymsPricesProvider(widget.Id)
//                                   : getNutritionsPricesProvider(widget.Id))
//                       .when(
//                           data: (prices) => Column(
//                                 children: [
//                                   PricesCard(
//                                     pricesModel: prices,
//                                     serviceProviderId: widget.serviceProviderId,
//                                   ),
//                                   if (user!.state == "1")
//                                     ElevatedButton(
//                                       onPressed: () =>
//                                           Get.bottomSheet(Container(
//                                         padding: EdgeInsets.all(10),
//                                         height: size.height * 0.42,
//                                         child: ListView(
//                                           children: [
//                                             TextFiled(
//                                               name: "Plan",
//                                               controller: plan!,
//                                               color: Pallete.lightgreyColor2,
//                                             ),
//                                             SizedBox(
//                                               height: size.height * 0.02,
//                                             ),
//                                             TextFiled(
//                                               name: "Description",
//                                               controller: description!,
//                                               color: Pallete.lightgreyColor2,
//                                             ),
//                                             SizedBox(
//                                               height: size.height * 0.01,
//                                             ),
//                                             TextFiled(
//                                               name: "Points",
//                                               controller: points!,
//                                               color: Pallete.lightgreyColor2,
//                                             ),
//                                             SizedBox(
//                                               height: size.height * 0.01,
//                                             ),
//                                             TextFiled(
//                                               name: "price",
//                                               controller: price!,
//                                               color: Pallete.lightgreyColor2,
//                                             ),
//                                             SizedBox(
//                                               height: size.width * 0.02,
//                                             ),
//                                             TextFiled(
//                                               name: "discount",
//                                               controller: discount!,
//                                               color: Pallete.lightgreyColor2,
//                                             ),
//                                             SizedBox(
//                                               height: size.width * 0.03,
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: ElevatedButton(
//                                                 onPressed: () {
//                                                   prices.planDescriptions
//                                                       .add(description!.text);
//                                                   prices.planName
//                                                       .add(plan!.text);
//                                                   prices.prices
//                                                       .add(price!.text);
//                                                   prices.discount
//                                                       .add(discount!.text);
//                                                   prices.points
//                                                       .add(points!.text);
//                                                   updatePricesBenefits(
//                                                       prices.prices,
//                                                       prices.planName,
//                                                       prices.planDescriptions,
//                                                       prices.discount,
//                                                       prices.points);

//                                                   Get.back();
//                                                 },
//                                                 child: Text(
//                                                   'Add',
//                                                   style: TextStyle(
//                                                       color: Pallete.whiteColor,
//                                                       fontFamily: "Muller",
//                                                       fontSize:
//                                                           size.width * 0.05,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                                 style: ElevatedButton.styleFrom(
//                                                     fixedSize: Size(
//                                                         size.width * 0.6,
//                                                         size.height * 0.04),
//                                                     backgroundColor:
//                                                         Color.fromARGB(
//                                                             255, 52, 180, 189),
//                                                     shape: RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                     size.width *
//                                                                         0.02))),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         decoration: BoxDecoration(
//                                           gradient: LinearGradient(
//                                               colors:
//                                                   Pallete.listofGridientCard,
//                                               begin: Alignment.topLeft,
//                                               end: Alignment.bottomRight,
//                                               transform:
//                                                   GradientRotation(3.14 / 4)),
//                                         ),
//                                       )),
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             "assets/page-1/images/kamn_splash.png",
//                                             fit: BoxFit.contain,
//                                           ),
//                                           Text(
//                                             'Add New Plan',
//                                             style: TextStyle(
//                                                 color: Pallete.whiteColor,
//                                                 fontFamily: "Muller",
//                                                 fontSize: size.width * 0.05,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                         ],
//                                       ),
//                                       style: ElevatedButton.styleFrom(
//                                           fixedSize: Size(size.width * 0.6,
//                                               size.height * 0.04),
//                                           backgroundColor: Pallete.primaryColor,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       size.width * 0.02))),
//                                     ),
//                                 ],
//                               ),
//                           error: (error, StackTrace) {
//                             print(error);

//                             return ErrorText(error: error.toString());
//                           },
//                           loading: () => LottieBuilder.asset(
//                                 fit: BoxFit.contain,
//                                 AppImageAsset.loading,
//                                 repeat: true,
//                               ))
//                 ],
//               ))),
//     );
//   }
// }


//agora code

// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:call_me/featuers/chats/controller/chat_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:call_me/config/agora_config.dart';

// import '../../../core/common/loader.dart';
// import '../../../models/call.dart';

// class CallScreen extends ConsumerStatefulWidget {
//   final String channelId;
//   final Call call;
//   final bool isGroupChat;
//   const CallScreen({
//     Key? key,
//     required this.channelId,
//     required this.call,
//     required this.isGroupChat,
//   }) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
// }

// class _CallScreenState extends ConsumerState<CallScreen> {
//   AgoraClient? client;
//   String baseUrl = 'https://roaring-hummingbird-79438f.netlify.app';

//   @override
//   void initState() {
//     super.initState();
//     client = AgoraClient(
//       agoraConnectionData: AgoraConnectionData(
//         appId: AgoraConfig.appId,
//         channelName: widget.channelId,
//         tokenUrl: baseUrl,
//       ),
//     );
//     initAgora();
//   }

//   void initAgora() async {
//     await client!.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: client == null
//           ? const Loader()
//           : SafeArea(
//               child: Stack(
//                 children: [
//                   AgoraVideoViewer(client: client!),
//                   AgoraVideoButtons(
//                     client: client!,
//                     disconnectButtonChild: IconButton(
//                       onPressed: () async {
//                         await client!.engine.leaveChannel();
//                         ref
//                             .watch(ChatControllerProider.notifier)
//                             .endCall(context, widget.call.receiverId);
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.call_end),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

  // cupertino_icons: ^1.0.2
  // shared_preferences: ^2.0.17
  // http: ^1.1.0
  // dartz: ^0.10.1
  // lottie: ^2.3.2
  // rename: ^2.1.1
  // flutter_launcher_icons: ^0.13.1
  // firebase_core_platform_interface: ^4.8.0
  // intl: ^0.18.1
  // image_picker: ^1.0.4
  // firebase_core: ^2.15.1
  // firebase_storage: ^11.2.6
  // cloud_firestore: ^4.8.5
  // firebase_auth: ^4.7.3
  // google_sign_in: ^6.1.4
  // file_picker: ^5.2.1
  // flutter_riverpod: ^2.3.7
  // cached_network_image: ^3.2.3
  // fpdart: ^1.1.0
  // google_fonts: ^6.1.0
  // routemaster: ^1.0.1
  // flutter_native_splash: ^2.3.1
  // path_provider: ^2.0.11
  // permission_handler: ^10.2.0
  // get: ^4.6.1
  // uuid: ^3.0.6
  // image_cropper: ^5.0.0
  // carousel_slider: ^4.2.1
  // geolocator: ^10.1.0
  // geocoding: ^2.1.1
  // url_launcher: ^6.2.1
  // emoji_picker_flutter: ^1.6.1
  // table_calendar: ^3.0.9
  // convex_bottom_bar: ^3.2.0
  // flutter_rating_bar: ^4.0.1
  // flutter_otp_text_field: ^1.1.1
  // sign_in_button: ^3.0.0
  // flutter_custom_tabs: ^1.2.1
  // webview_flutter: ^4.4.4
  // awesome_dialog: ^3.1.0
  // animated_text_kit: ^4.2.2
  // simple_barcode_scanner: ^0.0.8
  // share_plus: ^7.1.0
  // flutter_ringtone_player: ^3.2.0
  // firebase_messaging: ^14.6.9
  // jiffy: ^6.0.0
  // dotted_border: ^2.1.0
  // any_link_preview: ^3.0.1
  // swipe_to: ^1.0.2
  // insta_image_viewer: ^1.0.2
  // rating_dialog: ^2.0.4
  // agora_rtc_engine: ^5.0.0
  // timeago: ^3.6.1
  // agora_uikit: ^1.0.4