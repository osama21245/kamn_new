import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/models/inbox_model.dart';
import 'package:kman/models/reserved_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/storage_repository.dart';
import '../../../core/providers/utils.dart';
import '../../../models/user_model.dart';
import '../repositories/user_repository.dart';

// final getUserReservisionss = FutureProvider(
//     (ref) => ref.watch(userControllerProvider.notifier).getUserResevisions());

final getUserJoindGroundsProvider = FutureProvider.family((ref, String uid) =>
    ref.watch(userControllerProvider.notifier).getuserJoindGrounds(uid));

final getUserDataProviderr = FutureProvider.family((ref, String uid) =>
    ref.watch(userControllerProvider.notifier).getUserData(uid));

//inBox

final getInBoxMessagesProviderr = FutureProvider.family((ref, String uid) =>
    ref.watch(userControllerProvider.notifier).getInBoxMessages(uid));

final userControllerProvider =
    StateNotifierProvider<UserController, StatusRequest>((ref) =>
        UserController(
            storageRepository: ref.watch(storageRepositoryProvider),
            userRepository: ref.watch(UserRepositoryProvider),
            ref: ref));

class UserController extends StateNotifier<StatusRequest> {
  final Ref _ref;
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;

  UserController(
      {required UserRepository userRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _userRepository = userRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(StatusRequest.success);

  void askForPlayers(String groundId, BuildContext context, String collection,
      ReserveModel reserveModel, int targetplayesNum) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final res = await _userRepository.askForPlayes(
        groundId, collection, reserveModel, targetplayesNum);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.toString(), context),
        (r) => showSnackBar("Your reserve Added Succefuly", context));
  }

  void leaveGame(String collection, String groundId, String reserveId,
      BuildContext context) async {
    final userId = _ref.watch(usersProvider)!.uid;

    final res = await _userRepository.leaveGame(
        collection, groundId, reserveId, userId);

    res.fold((l) => showSnackBar(l.message, context), (r) {
      //  Get.to(HomeMain());
      showSnackBar("You Leave The Game", context);
    });
  }

  Future<List<ReserveModel>> getuserJoindGrounds(String uid) {
    return _userRepository.getUserJoinedGrounds(uid);
  }

  Future<UserModel> getUserData(String userId) {
    return _userRepository.getUserData(userId);
  }

  //inBox
  void sendInboxToUser(String title, String description, bool isImageEnter,
      File imageFile, BuildContext context) async {
    final user = _ref.watch(usersProvider);
    String image = "";
    final id = Uuid().v1();
    if (isImageEnter) {
      final resImage = await _storageRepository.storeFile(
          path: "Inbox", id: id, file: imageFile);

      resImage.fold((l) => showSnackBar(l.toString(), context), (r) {
        image = r;
      });
    }

    InBoxModel inBoxModel = InBoxModel(
        id: id,
        title: title,
        image: image,
        description: description,
        userId: user!.uid,
        sentAt: DateTime.now());
    final res = await _userRepository.sendInboxToUser(inBoxModel);

    res.fold((l) => showSnackBar(l.message, context),
        (r) => showSnackBar("send message success", context));
  }

  Future<List<InBoxModel>> getInBoxMessages(String userId) {
    return _userRepository.getInBoxMessages(userId);
  }
}
