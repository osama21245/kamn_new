import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kman/core/class/reservisionParameters.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/homemain.dart';
import 'package:kman/models/reserved_model.dart';
import 'package:kman/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/play/repositories/play_repository.dart';
import 'package:kman/models/grounds_model.dart';
import '../../../core/providers/storage_repository.dart';
import '../../../core/providers/utils.dart';
import '../screens/animated_reservision_screen.dart';

final getSearchFootballGrounds = StreamProvider.family((ref, String query) =>
    ref.watch(playControllerProvider.notifier).searcFootballhGrounds(query));

final getSearchBasketballGrounds = StreamProvider.family((ref, String query) =>
    ref.watch(playControllerProvider.notifier).searcBasketBallhGrounds(query));

final getSearchPaddelGrounds = StreamProvider.family((ref, String query) =>
    ref.watch(playControllerProvider.notifier).searcBasketBallhGrounds(query));

final getSearchVolleyBallGrounds = StreamProvider.family((ref, String query) =>
    ref.watch(playControllerProvider.notifier).searchVolleyBallhGrounds(query));

//************************Modern search************************* */

final getFootballGrounds = FutureProvider(
    (ref) => ref.watch(playControllerProvider.notifier).getFootballhGrounds());

final getBasketballGrounds = FutureProvider((ref) =>
    ref.watch(playControllerProvider.notifier).getBasketBallhGrounds());

final getPaddelGrounds = FutureProvider(
    (ref) => ref.watch(playControllerProvider.notifier).getPaddelGrounds());

final getVolleyBallGrounds = FutureProvider((ref) =>
    ref.watch(playControllerProvider.notifier).getVolleyBallhGrounds());

//************************get grounds*************************** */

final getGroundsProvider = StreamProvider.autoDispose.family(
    (ref, String collection) =>
        ref.watch(playControllerProvider.notifier).getGrounds(collection));

final getGroundDataProvider = FutureProvider.autoDispose.family(
    (ref, Tuple2 tuple) => ref
        .watch(playControllerProvider.notifier)
        .getGroundData(tuple.value1, tuple.value2));

final getJoinGroundsProvider = StreamProvider.autoDispose.family((ref,
        String collection) =>
    ref.watch(playControllerProvider.notifier).getJoinReservisions(collection));

//======================get user reservision=============================

final getuserreserve = StreamProvider.autoDispose.family((ref, String uid) =>
    ref.watch(playControllerProvider.notifier).getuserreserve(uid));

final getJoinuserreserve = StreamProvider.autoDispose.family(
    (ref, String uid) =>
        ref.watch(playControllerProvider.notifier).getJoinuserreserve(uid));

//*********************admin************************ */

final getGroundOwnerReserveProvider = StreamProvider.autoDispose.family(
    (ref, String uid) =>
        ref.watch(playControllerProvider.notifier).getGroundOwnerReserve(uid));

final getreservisionsProvider = StreamProvider.autoDispose.family((
  ref,
  ReservationsParams reservationsParams,
) {
  final playController = ref.watch(playControllerProvider.notifier);
  // Use ref.read to manually manage the subscription and disposal
  final streamController = StreamController<List<ReserveModel>>();
  final subscription =
      playController.getReservisions(reservationsParams).listen(
            (data) => streamController.add(data),
            onError: (error) => streamController.addError(error),
          );

  // Dispose the subscription when the stream is no longer needed
  ref.onDispose(() {
    subscription.cancel();
    streamController.close();
  });
  return streamController.stream;
});

//**************************for admin************************* */

final getGroundsRequestsProvider = StreamProvider.family((ref,
        String collection) =>
    ref.watch(playControllerProvider.notifier).getGroundsRequests(collection));

final playControllerProvider =
    StateNotifierProvider<playController, StatusRequest>((ref) =>
        playController(
            storageRepository: ref.watch(storageRepositoryProvider),
            playRepository: ref.watch(PlayRepositoryProvider),
            ref: ref));

class playController extends StateNotifier<StatusRequest> {
  final Ref _ref;
  final PlayRepository _playRepository;
  final StorageRepository _storageRepository;

  playController(
      {required PlayRepository playRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _playRepository = playRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(StatusRequest.success);

  void reserve(BuildContext context, ReserveModel reserveModel, int points,
      String groundOwnerId) async {
    //here ground owner is the real owner of the ground that his id is linked with the ground
    String id = Uuid().v1();
    reserveModel.id = id;
    final user = _ref.watch(usersProvider);

    state = StatusRequest.loading;
    final res = await _playRepository.reserve(reserveModel, user!.uid, points);
    res.fold((l) => showSnackBar(l.toString(), context), (r) async {
      UserModel user2 = user;
      user2.points = points;
      await _ref.watch(usersProvider.notifier).update((state) => user2);
      await saveUserModelToPrefs(user2);
      await _playRepository.pushOrderNotification("New reservision",
          "You have a new reservision", "users$groundOwnerId");
      state = StatusRequest.success;
      Get.to(() => const AnimatedReservisionScreen());
      showSnackBar("Your reserve Added Succefuly", context);
    });
  }

  Future<void> saveUserModelToPrefs(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert UserModel to JSON and save it in shared preferences
    String userModelJson = json.encode(userModel.toJson());
    prefs.setString('userModel', userModelJson);
  }

  void gpsTracking(double long, double lat, BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _playRepository.gpsTracking(long, lat);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context), (r) => null);
  }

  void askForPlayers(
      String reservisionId, int targetplayesNum, BuildContext context) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final res =
        await _playRepository.askForPlayes(reservisionId, targetplayesNum);
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.toString(), context),
        (r) => showSnackBar("Your reqest is approved", context));
  }

  void cancelReservision(
    String reservisionId,
    BuildContext context,
  ) async {
    final res = await _playRepository.cancleReservison(reservisionId);
    res.fold((l) => null,
        (r) => showSnackBar("Your reserve Cancelled Succefuly", context));
  }

  void changeReadyToPlay(BuildContext context) async {
    var user = _ref.watch(usersProvider);
    final res =
        await _playRepository.changeReadyToPlay(user!.uid, !user.isactive);

    res.fold((l) => showSnackBar(l.message, context), (r) async {
      user.isactive = !user.isactive;
      await _ref.watch(usersProvider.notifier).update((state) => user);
      await saveUserModelToPrefs(user);
    });
  }

  void joinGame(String reserveId, BuildContext context, int points) async {
    final user = _ref.watch(usersProvider);
    final res = await _playRepository.joinGame(reserveId, user!.uid, points);
    res.fold((l) => showSnackBar(l.message, context), (r) async {
      UserModel user2 = user;
      user2.points = points;
      await _ref.watch(usersProvider.notifier).update((state) => user2);
      await saveUserModelToPrefs(user2);
      showSnackBar("You join succefuly", context);
    });
  }

  void lastjoinGame(String reserveId, BuildContext context, int points,
      String reservisionOwnerId) async {
    //reservision owner here is the user who get the reservision not the ground owner
    final user = _ref.watch(usersProvider);
    final res =
        await _playRepository.LastjoinGame(reserveId, user!.uid, points);
    res.fold((l) => showSnackBar(l.message, context), (r) async {
      UserModel user2 = user;
      user2.points = points;
      await _ref.watch(usersProvider.notifier).update((state) => user2);
      await saveUserModelToPrefs(user2);
      await _playRepository.pushOrderNotification(
          "Reservision complete",
          "Your reservision has completed succesfully ${user.name}",
          "users${reservisionOwnerId}");
      showSnackBar("You join succefuly", context);
    });
  }

  void leaveGame(String reserveId, BuildContext context, int points) async {
    final user = _ref.watch(usersProvider);
    final res = await _playRepository.leaveGame(reserveId, user!.uid, points);

    res.fold((l) => showSnackBar(l.message, context), (r) async {
      UserModel user2 = user;
      user2.points = points;
      await saveUserModelToPrefs(user2);
      await _ref.watch(usersProvider.notifier).update((state) => user2);
      showSnackBar("You Leave The Game", context);
    });
  }

  void activeGround(String groundId, String collection, String userId,
      BuildContext context) async {
    state = StatusRequest.loading;
    final res = await _playRepository.activePlay(userId, collection, groundId);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => const HomeMain());
    });
  }

  //**************************update *********************** */

  void updateGround(String groundId, String collection, File? logo,
      GroundModel groundModel, BuildContext context) async {
    state = StatusRequest.loading;
    if (logo != null) {
      final res = await _storageRepository.storeFile(
          path: "Coach", id: groundModel.id, file: logo);

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        groundModel.image = r;
      });
    }
    final res =
        await _playRepository.updateGround(groundModel, collection, groundId);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.message, context), (r) {
      Get.offAll(() => const HomeMain());
    });
  }

  Stream<List<GroundModel>> getGrounds(String collection) {
    return _playRepository.getGrounds(collection);
  }

  Future<GroundModel> getGroundData(String collection, String groundId) {
    return _playRepository.getGroundData(collection, groundId);
  }

  Stream<List<ReserveModel>> getReservisions(
      ReservationsParams reservationsParams) {
    return _playRepository.getReservisions(reservationsParams.collection,
        reservationsParams.groundId, reservationsParams.day);
  }

  Stream<List<ReserveModel>> getJoinReservisions(String collection) {
    return _playRepository.getJoinReservisions(collection);
  }

  //==================get user reservisions=================

  Stream<List<ReserveModel>> getuserreserve(String uid) {
    return _playRepository.getUserreserve(uid);
  }

  Stream<List<ReserveModel>> getJoinuserreserve(String uid) {
    return _playRepository.getJoinUserreserve(uid);
  }

  //*************************admin******************************************** */
  Stream<List<ReserveModel>> getGroundOwnerReserve(String uid) {
    return _playRepository.getGroundOwnerReserve(uid);
  }
  //**************************search*******************************************

  Stream<List<GroundModel>> searcFootballhGrounds(String query) {
    return _playRepository.searchFootballGrounds(query);
  }

  Stream<List<GroundModel>> searcBasketBallhGrounds(String query) {
    return _playRepository.searchBasketBallGrounds(query);
  }

  Stream<List<GroundModel>> searcPaddelGrounds(String query) {
    return _playRepository.searchPadelGrounds(query);
  }

  Stream<List<GroundModel>> searchVolleyBallhGrounds(String query) {
    return _playRepository.searchVolleyBallGrounds(query);
  }

  //**************************Modern search*******************************************

  Future<List<GroundModel>> getFootballhGrounds() {
    return _playRepository.getFootballGrounds();
  }

  Future<List<GroundModel>> getBasketBallhGrounds() {
    return _playRepository.getBasketBallGrounds();
  }

  Future<List<GroundModel>> getPaddelGrounds() {
    return _playRepository.GetPadelGrounds();
  }

  Future<List<GroundModel>> getVolleyBallhGrounds() {
    return _playRepository.getVolleyBallGrounds();
  }

  //**************************futuers only for ground owner*******************************************

  void setGround(
      double long,
      double lat,
      String address,
      int price,
      String name,
      String phone,
      String futures,
      File FilegroundImage,
      BuildContext context,
      String collection,
      int groundPlayersNum,
      String city,
      String region,
      bool fromAsk) async {
    state = StatusRequest.loading;
    if (!mounted) {
      // Check if the widget is still mounted
      return;
    }
    String groundownerId = _ref.watch(usersProvider)!.uid;
    String id = Uuid().v1();
    final user = _ref.read(usersProvider);
    String groundImage = "";

    final res = await _storageRepository.storeFile(
        path: "Grounds", id: "${collection}$id", file: FilegroundImage);

    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      groundImage = r;
    });
//set data
    if (groundImage != "") {
      GroundModel groundModel = GroundModel(
          gallery: [],
          city: city,
          region: region,
          groundnumber: phone,
          rating: 0,
          groundPlayersNum: groundPlayersNum,
          id: id,
          name: name,
          address: address,
          groundOwnerId: fromAsk ? user!.uid : "",
          image: groundImage,
          price: price,
          futuers: futures,
          long: long,
          lat: lat);

      final res =
          await _playRepository.setGround(groundModel, collection, fromAsk);
      if (mounted) {
        state = StatusRequest.success;
        res.fold((l) => showSnackBar(l.toString(), context), (r) {
          showSnackBar("Your Ground Added Successfully", context);
          Get.offAll(() => const HomeMain());
        });
      }
    }
  }

  void setResrvision(
      String groundId,
      BuildContext context,
      String collection,
      int maxPlayersNum,
      String time,
      String day,
      String groundImage,
      String groundOwner) async {
    state = StatusRequest.loading;
    final user = _ref.watch(usersProvider)!.uid;
    String id = Uuid().v1();

    ReserveModel reserveModel = ReserveModel(
        groundOwnerId: groundOwner,
        maxPlayersNum: maxPlayersNum,
        category: collection,
        isJoiner: false,
        groundImage: groundImage,
        targetplayesNum: 0,
        id: id,
        groundId: groundId,
        userId: groundImage,
        reservisionMakerId: user,
        iscomplete: true,
        collaborations: [],
        time: time,
        day: day,
        isresrved: false);

    final res = await _playRepository.setreservision(
        groundId, collection, reserveModel);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.toString(), context), (r) {
      Get.to(() => AnimatedReservisionScreen());
      showSnackBar("Your reserve Added Succefuly", context);
    });
  }
  //**************************for admin************************************************************

  void setGroundRequest(
      double long,
      double lat,
      String address,
      int price,
      String name,
      String phone,
      String futures,
      String image,
      BuildContext context,
      String collection,
      int groundPlayersNum,
      String city,
      String region) async {
    state = StatusRequest.loading;
    if (!mounted) {
      // Check if the widget is still mounted
      return;
    }
    String groundownerId = _ref.watch(usersProvider)!.uid;
    String id = Uuid().v1();
    final user = _ref.read(usersProvider);

    GroundModel groundModel = GroundModel(
        city: city,
        region: region,
        groundnumber: phone,
        gallery: [],
        rating: 0,
        groundPlayersNum: groundPlayersNum,
        id: id,
        name: name,
        address: address,
        groundOwnerId: user!.uid,
        image: image,
        price: price,
        futuers: futures,
        long: long,
        lat: lat);

    final res = await _playRepository.setGround(groundModel, collection, false);
    if (mounted) {
      state = StatusRequest.success;
      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        showSnackBar("Your Ground Added Successfully", context);
      });
    }
  }

  void deleteGroundRequest(
      String groundId, String collection, BuildContext context) async {
    final res = await _playRepository.deleteGroundRequest(groundId, collection);
    res.fold((l) => null, (r) {
      Navigator.of(context).pop();
    });
  }

  Stream<List<GroundModel>> getGroundsRequests(String collection) {
    return _playRepository.getGroundsRequests(collection);
  }
}
