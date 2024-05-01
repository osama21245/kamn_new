// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kman/core/faliure.dart';
// import 'package:kman/core/providers/firebase_providers.dart';
// import 'package:kman/core/type_def.dart';
// import 'package:kman/models/live_stream_chat_model.dart';
// import 'package:kman/models/live_streaming_model.dart';

// final LiveStreamingRepositoryProvider = Provider(
//     (ref) => LiveStreamingRepository(firestore: ref.watch(FirestoreProvider)));

// class LiveStreamingRepository {
//   final FirebaseFirestore _firestore;

//   LiveStreamingRepository({required FirebaseFirestore firestore})
//       : _firestore = firestore;

//   CollectionReference get _liveStreaming =>
//       _firestore.collection("liveStreaming");

//   // Future<List<CoacheModel>> getCoaches() {
//   //   return _coaches.get().then((value) {
//   // List<CoacheModel> coaches = [];
//   // for (var document in value.docs) {
//   //   coaches
//   //       .add(CoacheModel.fromMap(document.data() as Map<String, dynamic>));
//   // }
//   // return coaches;
//   // });
//   // }

//   FutureVoid setLiveStreaming(LiveStreamingModel liveStreamingModel) async {
//     try {
//       if ((await _liveStreaming.doc(liveStreamingModel.channelId).get())
//           .exists) {
//         return right(_liveStreaming
//             .doc(liveStreamingModel.channelId)
//             .set(liveStreamingModel.toMap()));
//       } else {
//         throw "You can't make two streams at the same time";
//       }
//     } on FirebaseException catch (e) {
//       throw e.toString();
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   FutureVoid setLiveStreamingComment(
//       LiveStreamChatModel liveStreamChatModel, String channelId) async {
//     try {
//       return right(_liveStreaming
//           .doc(channelId)
//           .collection("comment")
//           .doc(liveStreamChatModel.id)
//           .set(liveStreamChatModel.toMap()));
//     } on FirebaseException catch (e) {
//       throw e.toString();
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   Stream<List<LiveStreamChatModel>> getLiveStreamingComment(String channelId) {
//     return _liveStreaming
//         .doc(channelId)
//         .collection("comment")
//         .snapshots()
//         .map((event) {
//       List<LiveStreamChatModel> comments = [];
//       for (var document in event.docs) {
//         comments.add(LiveStreamChatModel.fromMap(
//             document.data() as Map<String, dynamic>));
//       }
//       return comments;
//     });
//   }

//   Stream<List<LiveStreamingModel>> getLiveStreaming() {
//     return _liveStreaming.snapshots().map((event) {
//       List<LiveStreamingModel> streams = [];
//       for (var document in event.docs) {
//         streams.add(LiveStreamingModel.fromMap(
//             document.data() as Map<String, dynamic>));
//       }
//       return streams;
//     });
//   }

//   FutureVoid leaveChannel(String channelId) async {
//     try {
//       return right(_liveStreaming.doc(channelId).delete());
//     } on FirebaseException catch (e) {
//       throw e.toString();
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   FutureVoid updateviewCount(bool increment, String channelId) async {
//     try {
//       return right(_liveStreaming
//           .doc(channelId)
//           .update({"viewers": FieldValue.increment(increment ? 1 : -1)}));
//     } on FirebaseException catch (e) {
//       throw e.toString();
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }
// }
