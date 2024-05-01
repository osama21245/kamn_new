// import 'dart:convert';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:kman/core/constants/agoraConfig.dart';
// import 'package:kman/featuers/auth/controller/auth_controller.dart';
// import 'package:kman/featuers/live_streaming/controller/live_streaming_controller.dart';
// import 'package:kman/homemain.dart';
// import 'package:kman/models/user_model.dart';
// import 'package:permission_handler/permission_handler.dart';

// // import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// // import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import 'package:http/http.dart' as http;
// import '../widgets/custom_button.dart';
// import '../widgets/custom_chat.dart';

// class LiveScreen extends ConsumerStatefulWidget {
//   final bool isBroadcaster;
//   final String channelId;
//   const LiveScreen(
//       {super.key, required this.isBroadcaster, required this.channelId});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LiveScreenState();
// }

// class _LiveScreenState extends ConsumerState<LiveScreen> {
//   late final RtcEngine _engine;
//   List<int> remoteUidList = [];
//   bool switchCamera = true;
//   bool isMuted = false;
//   bool isScreenSharing = false;

//   String baseUrl = "https://gleaming-marzipan-c24952.netlify.app";

//   String? token;

//   Future<void> getToken() async {
//     final res = await http.get(
//       Uri.parse(baseUrl +
//           '/rtc/' +
//           widget.channelId +
//           '/publisher/userAccount/' +
//           ref.read(usersProvider)!.uid +
//           '/'),
//     );

//     if (res.statusCode == 200) {
//       setState(() {
//         token = res.body;
//         token = jsonDecode(token!)['rtcToken'];
//       });
//     } else {
//       debugPrint('Failed to fetch the token');
//     }
//   }

//   @override
//   void dispose() {
//     _engine.release();
//     super.dispose();
//   }

//   void _addListeners() {
//     // _engine.setEventHandler(
//     //     RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
//     //   debugPrint('joinSucess${channel}$uid $elapsed');
//     // }, userJoined: (uid, elapsed) {
//     //   debugPrint('userJoin $elapsed');
//     //   setState(() {
//     //     remoteUid.add(uid);
//     //   });
//     // }, userOffline: (uid, reason) {
//     //   debugPrint('userLeave $uid $reason');
//     //   setState(() {
//     //     remoteUid.removeWhere((element) => element == uid);
//     //   });
//     // }, leaveChannel: (stats) {
//     //   debugPrint('leave $stats');
//     //   setState(() {
//     //     remoteUid.clear();
//     //   });
//     // }, tokenPrivilegeWillExpire: (token) async {
//     //   await getToken();
//     //   await _engine.renewToken(token);
//     // }));

//     _engine.registerEventHandler(RtcEngineEventHandler(
//       onJoinChannelSuccess: (connection, elapsed) {
//         print("$connection , $elapsed");
//       },
//       onUserJoined: (connection, remoteUid, elapsed) {
//         debugPrint('userJoin $elapsed $remoteUid ,$connection');
//         setState(() {
//           remoteUidList.add(remoteUid);
//         });
//       },
//       onUserOffline: (connection, remoteUid, reason) {
//         debugPrint('userLeave $connection , $remoteUidList $reason');
//         setState(() {
//           remoteUidList.removeWhere((element) => element == remoteUid);
//         });
//       },
//       onLeaveChannel: (connection, stats) {
//         debugPrint('leave $stats');
//         setState(() {
//           remoteUidList.clear();
//         });
//       },
//       onTokenPrivilegeWillExpire: (connection, token) async {
//         await getToken();
//         await _engine.renewToken(token);
//       },
//     ));
//   }

//   void _switchCamera() {
//     _engine.switchCamera().then((value) {
//       setState(() {
//         switchCamera = !switchCamera;
//       });
//     }).catchError((err) {
//       debugPrint('switchCamera $err');
//     });
//   }

//   void onToggleMute() async {
//     setState(() {
//       isMuted = !isMuted;
//     });
//     await _engine.muteLocalAudioStream(isMuted);
//   }

//   void _joinChannel() async {
//     await getToken();
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       await [Permission.microphone, Permission.camera].request();
//     }
//     await _engine.joinChannelWithUserAccount(
//         token: token!,
//         channelId: widget.channelId,
//         userAccount: ref.watch(usersProvider)!.uid);
//   }

//   _initEngine() async {
//     //  _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
//     _engine = await createAgoraRtcEngine();

//     _addListeners();
//     await _engine.enableVideo();
//     await _engine.startPreview();
//     // await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
//     await _engine
//         .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);

//     // _engine.setClientRole(
//     //     widget.isBroadcaster ? ClientRole.Broadcaster : ClientRole.Audience);
//     _engine.setClientRole(
//         role: widget.isBroadcaster
//             ? ClientRoleType.clientRoleBroadcaster
//             : ClientRoleType.clientRoleAudience);
//     _joinChannel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = ref.read(usersProvider);
//     _leaveChannel() async {
//       await _engine.leaveChannel();
//       if ('${user!.uid}${user.name}' == widget.channelId) {
//         ref
//             .watch(liveStreamingControllerProvider.notifier)
//             .leaveChannel(widget.channelId, context);
//       } else {
//         ref
//             .watch(liveStreamingControllerProvider.notifier)
//             .updaeViewCount(widget.channelId, false);
//       }
//       Get.to(() => HomeMain());
//     }

//     return WillPopScope(
//       onWillPop: () async {
//         await _leaveChannel();
//         return Future.value(true);
//       },
//       child: Scaffold(
//         bottomNavigationBar: widget.isBroadcaster
//             ? Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: CustomButton(
//                     text: 'End Stream', onTap: () {} //_leaveChannel,
//                     ),
//               )
//             : null,
//         body: Padding(
//           padding: const EdgeInsets.all(8),
//           child:
//               //  Row(
//               //   children: [
//               //     Expanded(
//               //       child: Column(
//               //         children: [
//               //           _renderVideo(user, isScreenSharing),
//               //           if ("${user!.uid}${user.name}" == widget.channelId)
//               //             Column(
//               //               mainAxisSize: MainAxisSize.min,
//               //               mainAxisAlignment: MainAxisAlignment.start,
//               //               children: [
//               //                 InkWell(
//               //                   onTap: _switchCamera,
//               //                   child: const Text('Switch Camera'),
//               //                 ),
//               //                 InkWell(
//               //                   onTap: onToggleMute,
//               //                   child: Text(isMuted ? 'Unmute' : 'Mute'),
//               //                 ),
//               //                 InkWell(
//               //                   onTap: isScreenSharing
//               //                       ? _stopScreenShare
//               //                       : _startScreenShare,
//               //                   child: Text(
//               //                     isScreenSharing
//               //                         ? 'Stop ScreenSharing'
//               //                         : 'Start Screensharing',
//               //                   ),
//               //                 ),
//               //               ],
//               //             ),
//               //         ],
//               //       ),
//               //     ),
//               //     Chat(channelId: widget.channelId),
//               //   ],
//               // ),
//               Column(
//             children: [
//               _renderVideo(user!),
//               if ("${user.uid}${user.name}" == widget.channelId)
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       onTap: _switchCamera,
//                       child: const Text('Switch Camera'),
//                     ),
//                     InkWell(
//                       onTap: onToggleMute,
//                       child: Text(isMuted ? 'Unmute' : 'Mute'),
//                     ),
//                   ],
//                 ),
//               Expanded(
//                 child: Chat(
//                   channelId: widget.channelId,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _renderVideo(UserModel user) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: "${user.uid}${user.name}" == widget.channelId
//           ? AgoraVideoView(
//               controller: VideoViewController(
//                 rtcEngine: _engine,
//                 canvas: VideoCanvas(
//                     uid: remoteUidList[0]), // Use uid = 0 for local view
//               ),
//             )
//           : remoteUidList.isNotEmpty
//               ? AgoraVideoView(
//                   controller: VideoViewController.remote(
//                     rtcEngine: _engine,
//                     canvas: VideoCanvas(uid: remoteUidList[0]),
//                     connection: RtcConnection(channelId: widget.channelId),
//                   ),
//                 )
//               : Container(),
//     );
//   }
// }
