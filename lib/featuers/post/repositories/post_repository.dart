import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/faliure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_def.dart';
import '../../../models/post_model_motivation.dart';
import '../../../core/data/notfication_data.dart';
import 'package:get/get.dart';

Provider<PostRepository> PostRepositoryProvider = Provider(
    (ref) => PostRepository(firebaseFirestore: ref.watch(FirestoreProvider)));

class PostRepository {
  FirebaseFirestore _firebaseFirestore;

  PostRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _postsMotivation => _firebaseFirestore
      .collection(FirebaseConstants.postsMotivationCollection);

  CollectionReference get _users =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  NotficationData notificationData = NotficationData(Get.find());

  Future<Either<Failure, String>> pushOrderNotification(
      String title, String body, String topic) async {
    try {
      var response =
          await notificationData.pushNotifications(title, body, topic);
      return right("correct");
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid addPost(PostMotivation post) async {
    try {
      return right(_postsMotivation.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<PostMotivation>> showPosts() {
    return _postsMotivation.snapshots().map((event) => event.docs
        .map((e) => PostMotivation.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }

  FutureVoid deletePost(String postid) async {
    try {
      return right(_postsMotivation.doc(postid).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void upvote(PostMotivation post, String userId) async {
    if (post.upvotes.contains(userId)) {
      _postsMotivation.doc(post.id).update({
        'upvotes': FieldValue.arrayRemove([userId]),
      });
    } else {
      _postsMotivation.doc(post.id).update({
        'upvotes': FieldValue.arrayUnion([userId]),
      });
    }
  }

  Stream<PostMotivation> getPostById(String postId) {
    return _postsMotivation.doc(postId).snapshots().map((event) =>
        PostMotivation.fromMap(event.data() as Map<String, dynamic>));
  }
}
