// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kman/core/class/statusrequest.dart';
// import 'package:kman/featuers/auth/controller/auth_controller.dart';
// import 'package:kman/featuers/live_streaming/screens/live_screen.dart';
// import 'package:kman/models/live_stream_chat_model.dart';
// import 'package:kman/models/live_streaming_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:uuid/uuid.dart';
// import '../../../core/providers/storage_repository.dart';
// import '../../../core/providers/utils.dart';
// import '../repositories/live_streaming_repository.dart';

// final getLiveStreamCommentsProvider = StreamProvider.family(
//     (ref, String channelId) => ref
//         .watch(liveStreamingControllerProvider.notifier)
//         .getLiveStreamComments(channelId));

// final getLiveStreamProvider = StreamProvider((ref) =>
//     ref.watch(liveStreamingControllerProvider.notifier).getLiveStream());

// final liveStreamingControllerProvider =
//     StateNotifierProvider<LiveStreamingController, StatusRequest>((ref) =>
//         LiveStreamingController(
//             storageRepository: ref.watch(storageRepositoryProvider),
//             liveStreamingRepository: ref.watch(LiveStreamingRepositoryProvider),
//             ref: ref));

// class LiveStreamingController extends StateNotifier<StatusRequest> {
//   final Ref _ref;
//   final LiveStreamingRepository _liveStreamingRepository;
//   final StorageRepository _storageRepository;

//   LiveStreamingController(
//       {required LiveStreamingRepository liveStreamingRepository,
//       required Ref ref,
//       required StorageRepository storageRepository})
//       : _liveStreamingRepository = liveStreamingRepository,
//         _ref = ref,
//         _storageRepository = storageRepository,
//         super(StatusRequest.success);

//   // Future<List<CoacheModel>> getCoaches() {
//   //   return _liveStreamingRepository.getCoaches();
//   // }

//   void leaveChannel(String channelId, BuildContext context) async {
//     final res = await _liveStreamingRepository.leaveChannel(channelId);
//     res.fold((l) => showSnackBar("Check your connection", context),
//         (r) => showSnackBar("You end your stream", context));
//   }

//   void updaeViewCount(String channelId, bool increment) async {
//     final res = await _liveStreamingRepository.leaveChannel(channelId);
//     res.fold((l) => null, (r) => null);
//   }

//   Stream<List<LiveStreamChatModel>> getLiveStreamComments(String channelId) {
//     return _liveStreamingRepository.getLiveStreamingComment(channelId);
//   }

//   Stream<List<LiveStreamingModel>> getLiveStream() {
//     return _liveStreamingRepository.getLiveStreaming();
//   }

//   void setLiveStreamComment(
//     String message,
//     String channelId,
//     BuildContext context,
//   ) async {
//     state = StatusRequest.loading;
//     final id = Uuid().v1();
//     final user = _ref.watch(usersProvider);

//     LiveStreamChatModel liveStreamingModel = LiveStreamChatModel(
//         id: id, uid: user!.uid, username: user.name, message: message);
//     final res = await _liveStreamingRepository.setLiveStreamingComment(
//         liveStreamingModel, channelId);
//     state = StatusRequest.success;

//     res.fold((l) => showSnackBar(l.toString(), context), (r) {});
//   }

//   void setLiveStream(
//     String title,
//     BuildContext context,
//     File fileLiveStreamingImage,
//   ) async {
//     state = StatusRequest.loading;
//     String photo = "";
//     final user = _ref.watch(usersProvider);
//     final res = await _storageRepository.storeFile(
//         path: "LiveStreaming", id: user!.uid, file: fileLiveStreamingImage);

//     res.fold((l) => showSnackBar(l.toString(), context), (r) {
//       photo = r;
//     });

//     if (photo != "") {
//       LiveStreamingModel liveStreamingModel = LiveStreamingModel(
//           title: title,
//           image: photo,
//           uid: user!.uid,
//           username: user.name,
//           viewers: 0,
//           channelId: "${user.uid}${user.name}",
//           startedAt: DateTime.now());

//       final res =
//           await _liveStreamingRepository.setLiveStreaming(liveStreamingModel);
//       state = StatusRequest.success;

//       res.fold((l) => showSnackBar(l.toString(), context), (r) {
//         Get.to(() => LiveScreen(
//             isBroadcaster: true, channelId: "${user.uid}${user.name}"));
//         showSnackBar("Your stream start", context);
//       });
//     }
//   }
// }
