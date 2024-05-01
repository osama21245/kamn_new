import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/firebase_constants.dart';
import 'package:kman/core/faliure.dart';
import 'package:kman/core/providers/firebase_providers.dart';
import 'package:kman/core/type_def.dart';
import 'package:kman/models/grounds_model.dart';
import 'package:kman/models/reserved_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/data/notfication_data.dart';
import '../../../theme/pallete.dart';

final PlayRepositoryProvider =
    Provider((ref) => PlayRepository(firestore: ref.watch(FirestoreProvider)));

class PlayRepository {
  final FirebaseFirestore _firestore;

  PlayRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  NotficationData notificationData = NotficationData(Get.find());

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
  CollectionReference get _reserve =>
      _firestore.collection(FirebaseConstants.reserveCollection);

  CollectionReference get _reservisions =>
      _firestore.collection(FirebaseConstants.reserveCollection);

  FutureVoid reserve(ReserveModel reserveModel, String uid, int points) async {
    try {
      _users.doc(uid).update({"points": points});

      return right(
          _reservisions.doc(reserveModel.id).set(reserveModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid cancleReservison(String reservisionId) async {
    try {
      return right(_reservisions.doc(reservisionId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid gpsTracking(
    double long,
    double lat,
  ) async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();

      if (statuses[Permission.location]!.isGranted) {
        String url =
            "https://www.google.com/maps/search/?api=1&query=$lat,$long";
        // return right(launch(
        //   url,
        //   customTabsOption: CustomTabsOption(
        //     toolbarColor: Pallete.primaryColor,
        //     enableDefaultShare: true,
        //     enableUrlBarHiding: true,
        //     showPageTitle: true,
        //     animation: CustomTabsSystemAnimation.slideIn(),
        //     extraCustomTabs: const <String>[
        //       // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
        //       'org.mozilla.firefox',
        //       // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
        //       'com.microsoft.emmx',
        //     ],
        //   ),
        //   safariVCOption: SafariViewControllerOption(
        //     preferredBarTintColor: Pallete.primaryColor,
        //     preferredControlTintColor: Pallete.whiteColor,
        //     barCollapsingEnabled: true,
        //     entersReaderIfAvailable: false,
        //     dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        //   ),
        // ));

        return right(launchUrl(
          Uri.parse(url),
          customTabsOptions: CustomTabsOptions(
            colorSchemes: CustomTabsColorSchemes.defaults(
              toolbarColor: Pallete.primaryColor,
            ),
            shareState: CustomTabsShareState.on,
            urlBarHidingEnabled: true,
            showTitle: true,
            closeButton: CustomTabsCloseButton(
              icon: CustomTabsCloseButtonIcons.back,
            ),
          ),
          safariVCOptions: SafariViewControllerOptions(
            preferredBarTintColor: Pallete.primaryColor,
            preferredControlTintColor: Pallete.whiteColor,
            barCollapsingEnabled: true,
            dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          ),
        ));
      } else {
        throw "Dont have permission";
      }
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      return left(Failure(e.toString()));
    }
  }

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

  FutureVoid joinGame(String reserveId, String userId, int points) async {
    try {
      _reserve.doc(reserveId).update({
        'collaborations': FieldValue.arrayUnion([userId]),
      });
      _users.doc(userId).update({"points": points});
      return right(_reservisions.doc(reserveId).update({
        'collaborations': FieldValue.arrayUnion([userId]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid LastjoinGame(String reserveId, String userId, int points) async {
    try {
      _users.doc(userId).update({"points": points});
      return right(_reservisions.doc(reserveId).update({
        'collaborations': FieldValue.arrayUnion([userId]),
        "iscomplete": true
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid leaveGame(String reserveId, String userId, int points) async {
    try {
      _users.doc(userId).update({"points": points});

      return right(_reservisions.doc(reserveId).update({
        'collaborations': FieldValue.arrayRemove([userId]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid activePlay(
      String userId, String collection, String groundId) async {
    try {
      return right(_firestore
          .collection(collection)
          .doc(groundId)
          .update({"groundOwnerId": userId}));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //********************update************************ */

  FutureVoid updateGround(
      GroundModel groundModel, String collection, String groundId) async {
    try {
      return right(_firestore
          .collection(collection)
          .doc(groundId)
          .update(groundModel.toMap()));
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid changeReadyToPlay(String uid, bool isActive) async {
    try {
      return right(_users.doc(uid).update({'isactive': isActive}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Either askForPlayes(String reservisionId, int targetplayesNum) {
    try {
      return right(_reserve
          .doc(reservisionId)
          .update({"iscomplete": false, "targetplayesNum": targetplayesNum}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //********************get ground reservisions*********************** */

  Stream<List<GroundModel>> getGrounds(String collection) {
    return _firestore.collection(collection).snapshots().map((event) {
      List<GroundModel> grounds = [];
      for (var document in event.docs) {
        grounds
            .add(GroundModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return grounds;
    });
  }

  Future<GroundModel> getGroundData(String collection, String groundId) {
    return _firestore.collection(collection).doc(groundId).get().then((value) {
      return GroundModel.fromMap(value.data() as Map<String, dynamic>);
    });
  }

  Stream<List<ReserveModel>> getReservisions(
      String collection, String groundId, String day) {
    return _reservisions
        .where("day", isEqualTo: day)
        .where("groundId", isEqualTo: groundId)
        .where("isresrved", isEqualTo: true)
        .snapshots()
        .map((event) {
      List<ReserveModel> grounds = [];
      for (var document in event.docs) {
        grounds
            .add(ReserveModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return grounds;
    });
  }

  Stream<List<ReserveModel>> getJoinReservisions(String collection) {
    return _reservisions
        .where("iscomplete", isEqualTo: false)
        .where("category", isEqualTo: collection)
        .snapshots()
        .map((event) {
      List<ReserveModel> grounds = [];
      for (var document in event.docs) {
        grounds
            .add(ReserveModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return grounds;
    });
  }

  //**********************get user  reservisions********************** */

  Stream<List<ReserveModel>> getUserreserve(String uid) {
    return _reservisions
        .where("userId", isEqualTo: uid)
        .snapshots()
        .map((event) {
      List<ReserveModel> grounds = [];
      for (var document in event.docs) {
        grounds
            .add(ReserveModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return grounds;
    });
  }

  Stream<List<ReserveModel>> getJoinUserreserve(String uid) {
    return _reservisions
        .where("collaborations", arrayContains: uid)
        .where("iscomplete", isEqualTo: false)
        .snapshots()
        .map((event) {
      List<ReserveModel> grounds = [];
      for (var document in event.docs) {
        grounds
            .add(ReserveModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return grounds;
    });
  }

  //**************admin************** */

  Stream<List<ReserveModel>> getGroundOwnerReserve(String uid) {
    return _reservisions
        .where("groundOwnerId", isEqualTo: uid)
        .snapshots()
        .map((event) {
      List<ReserveModel> grounds = [];
      for (var document in event.docs) {
        grounds
            .add(ReserveModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return grounds;
    });
  }

  //*************** Search *******************

  Stream<List<GroundModel>> searchFootballGrounds(String query) {
    return _firestore
        .collection("Football")
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<GroundModel> grounds = [];
      for (var community in event.docs) {
        grounds.add(GroundModel.fromMap(community.data()));
      }
      return grounds;
    });
  }

  Stream<List<GroundModel>> searchBasketBallGrounds(String query) {
    return _firestore
        .collection("Basketball")
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<GroundModel> grounds = [];
      for (var community in event.docs) {
        grounds.add(GroundModel.fromMap(community.data()));
      }
      return grounds;
    });
  }

  Stream<List<GroundModel>> searchPadelGrounds(String query) {
    return _firestore
        .collection("Padel")
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<GroundModel> grounds = [];
      for (var community in event.docs) {
        grounds.add(GroundModel.fromMap(community.data()));
      }
      return grounds;
    });
  }

  Stream<List<GroundModel>> searchVolleyBallGrounds(String query) {
    return _firestore
        .collection("Volleyball")
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<GroundModel> grounds = [];
      for (var community in event.docs) {
        grounds.add(GroundModel.fromMap(community.data()));
      }
      return grounds;
    });
  }

  //*************** Modersn search *******************

  Future<List<GroundModel>> getFootballGrounds() {
    return _firestore.collection("Football").get().then((value) {
      List<GroundModel> ground = [];
      for (var document in value.docs) {
        ground
            .add(GroundModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return ground;
    });
  }

  Future<List<GroundModel>> getBasketBallGrounds() {
    return _firestore.collection("Basketball").get().then((value) {
      List<GroundModel> ground = [];
      for (var document in value.docs) {
        ground
            .add(GroundModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return ground;
    });
  }

  Future<List<GroundModel>> GetPadelGrounds() {
    return _firestore.collection("Padel").get().then((value) {
      List<GroundModel> ground = [];
      for (var document in value.docs) {
        ground
            .add(GroundModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return ground;
    });
  }

  Future<List<GroundModel>> getVolleyBallGrounds() {
    return _firestore.collection("Volleyball").get().then((value) {
      List<GroundModel> ground = [];
      for (var document in value.docs) {
        ground
            .add(GroundModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return ground;
    });
  }

  //***************futures only for groun owner*******************
  FutureVoid setGround(
      GroundModel groundModel, String collection, bool fromAsk) async {
    try {
      return right(_firestore
          .collection(fromAsk ? "${collection}Request" : collection)
          .doc(groundModel.id)
          .set(groundModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setreservision(
      String groundId, String collection, ReserveModel reserveModel) async {
    try {
      _reserve..doc(reserveModel.id).set(reserveModel.toMap());

      return right(_firestore
          .collection(collection)
          .doc(groundId)
          .collection("reserve")
          .doc(reserveModel.id)
          .set(reserveModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //****************for admin*********************************** */

  FutureVoid deleteGroundRequest(String groundId, String collection) async {
    try {
      return right(
          _firestore.collection("${collection}Request").doc(groundId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<GroundModel>> getGroundsRequests(String collection) {
    return _firestore
        .collection("${collection}Request")
        .snapshots()
        .map((event) {
      List<GroundModel> grounds = [];
      for (var document in event.docs) {
        grounds
            .add(GroundModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return grounds;
    });
  }
}
