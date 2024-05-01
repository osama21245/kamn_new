// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:kman/featuers/live_streaming/controller/live_streaming_controller.dart';
// import 'package:lottie/lottie.dart';

// import '../../../core/common/error_text.dart';
// import '../../../core/constants/imgaeasset.dart';
// import 'live_screen.dart';
// import 'package:timeago/timeago.dart' as timeago;

// class FeedScreen extends ConsumerStatefulWidget {
//   const FeedScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _FeedScreenState();
// }

// class _FeedScreenState extends ConsumerState<FeedScreen> {
//   goToLiveScreen(String channelId) {
//     ref
//         .watch(liveStreamingControllerProvider.notifier)
//         .updaeViewCount(channelId, true);
//     Get.to(() => LiveScreen(
//           channelId: channelId,
//           isBroadcaster: false,
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(
//           top: 10,
//         ),
//         child: Column(
//           children: [
//             const Text(
//               'Live Users',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//               ),
//             ),
//             SizedBox(height: size.height * 0.03),
//             ref.watch(getLiveStreamProvider).when(
//                 data: (streams) {
//                   return Expanded(
//                     child: ListView.builder(
//                         itemCount: streams.length,
//                         itemBuilder: (context, index) {
//                           final stream = streams[index];

//                           return InkWell(
//                             onTap: () async => goToLiveScreen(stream.channelId),
//                             child: Container(
//                               height: size.height * 0.1,
//                               margin: const EdgeInsets.symmetric(vertical: 10),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   AspectRatio(
//                                     aspectRatio: 16 / 9,
//                                     child: Image.network(stream.image),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         stream.username,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                       Text(
//                                         stream.title,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text('${stream.viewers} watching'),
//                                       Text(
//                                         'Started ${timeago.format(stream.startedAt)}',
//                                       ),
//                                     ],
//                                   ),
//                                   IconButton(
//                                     onPressed: () {},
//                                     icon: const Icon(
//                                       Icons.more_vert,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                   );
//                 },
//                 error: (error, StackTrace) {
//                   print(error);

//                   return ErrorText(error: error.toString());
//                 },
//                 loading: () => LottieBuilder.asset(
//                       fit: BoxFit.contain,
//                       AppImageAsset.loading,
//                       repeat: true,
//                     ))
//           ],
//         ),
//       ),
//     );
//   }
// }
