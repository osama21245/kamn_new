import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/post/repositories/post_repository.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';
import '../../../core/providers/storage_repository.dart';
import '../../../core/utils.dart';
import '../../../models/post_model_motivation.dart';
import '../../auth/controller/auth_controller.dart';

final postControllerProvider =
    StateNotifierProvider<PostController, bool>((ref) {
  final postRepository = ref.watch(PostRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return PostController(
    postRepository: postRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});
final getPostsProvider = StreamProvider((ref) {
  final controller = ref.watch(postControllerProvider.notifier);
  return controller.showPosts();
});

final getPostByIdProvider = StreamProvider.family((ref, String postId) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.getPostById(postId);
});

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  PostController({
    required PostRepository postRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _postRepository = postRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void shareTextPost({
    required BuildContext context,
    required String title,
    required String description,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(usersProvider)!;

    final PostMotivation post = PostMotivation(
      id: postId,
      title: title,
      upvotes: [],
      downvotes: [],
      commentCount: 0,
      username: user.name,
      uid: user.uid,
      type: 'text',
      createdAt: DateTime.now(),
      awards: [],
      description: description,
    );

    final res = await _postRepository.addPost(post);

    state = false;
    res.fold((l) => showSnackBar(l.message, context), (r) async {
      final res = await _postRepository.pushOrderNotification(
          "$title", "$description", "users");
      res.fold((l) => showSnackBar("Check", context), (r) {});
      showSnackBar('Posted successfully!', context);
    });
  }

  void shareLinkPost({
    required BuildContext context,
    required String title,
    required String link,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(usersProvider)!;

    final PostMotivation post = PostMotivation(
      id: postId,
      title: title,
      upvotes: [],
      downvotes: [],
      commentCount: 0,
      username: user.name,
      uid: user.uid,
      type: 'link',
      createdAt: DateTime.now(),
      awards: [],
      link: link,
    );

    final res = await _postRepository.addPost(post);

    state = false;
    res.fold((l) => showSnackBar(l.message, context), (r) async {
      final res = await _postRepository.pushOrderNotification(
          "$title", "See in kamn", "users");
      res.fold((l) => showSnackBar("Check", context), (r) {});
      showSnackBar('Posted successfully!', context);
      Routemaster.of(context).pop();
    });
  }

  void shareImagePost({
    required BuildContext context,
    required String title,
    required File? file,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(usersProvider)!;
    final imageRes = await _storageRepository.storeFile(
      path: 'posts/kamn-motivation',
      id: postId,
      file: file,
    );

    imageRes.fold((l) => showSnackBar(l.toString(), context), (r) async {
      final PostMotivation post = PostMotivation(
        id: postId,
        title: title,
        upvotes: [],
        downvotes: [],
        commentCount: 0,
        username: user.name,
        uid: user.uid,
        type: 'image',
        createdAt: DateTime.now(),
        awards: [],
        link: r,
      );

      final res = await _postRepository.addPost(post);

      state = false;
      res.fold((l) => showSnackBar(l.message, context), (r) async {
        final res = await _postRepository.pushOrderNotification(
            "$title", "See in kamn", "users");
        res.fold((l) => showSnackBar("Check", context), (r) {});
        showSnackBar('Posted successfully!', context);
        Routemaster.of(context).pop();
      });
    });
  }

  Stream<List<PostMotivation>> showPosts() {
    return _postRepository.showPosts();
  }

  void deletePost(PostMotivation post, BuildContext context) async {
    final res = await _postRepository.deletePost(post.id);

    res.fold((l) => null,
        (r) => showSnackBar('Post Deleted successfully!', context));
  }

  void upvote(PostMotivation post) async {
    final uid = _ref.read(usersProvider)!.uid;
    _postRepository.upvote(post, uid);
  }

  Stream<PostMotivation> getPostById(String postId) {
    return _postRepository.getPostById(postId);
  }
}
