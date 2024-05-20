import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/constants/firebase_constants.dart';
import 'package:kman/core/faliure.dart';
import 'package:kman/core/providers/firebase_providers.dart';
import 'package:kman/core/type_def.dart';
import 'package:kman/models/grounds_model.dart';
import 'package:kman/models/reserved_model.dart';
import 'package:kman/models/user_model.dart';

import '../../../models/inbox_model.dart';

final UserRepositoryProvider =
    Provider((ref) => UserRepository(firestore: ref.watch(FirestoreProvider)));

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  CollectionReference get _inBox =>
      _firestore.collection(FirebaseConstants.inBoxCollection);

  CollectionReference get _reserve =>
      _firestore.collection(FirebaseConstants.reserveCollection);

  FutureVoid leaveGame(String collection, String groundId, String reserveId,
      String userId) async {
    try {
      return right(_firestore
          .collection(collection)
          .doc(groundId)
          .collection("reserve")
          .doc(reserveId)
          .update({
        'collaborations': FieldValue.arrayRemove([userId]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid askForPlayes(String groundId, String collection,
      ReserveModel reserveModel, int targetplayesNum) async {
    try {
      await _firestore
          .collection(collection)
          .doc(groundId)
          .collection("reserve")
          .doc(reserveModel.id)
          .update({"iscomplete": false, "targetplayesNum": targetplayesNum});

      return right(_users
          .doc("uid")
          .collection("reserve")
          .doc(reserveModel.id)
          .update({"iscomplete": false, "targetplayesNum": targetplayesNum}));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<List<ReserveModel>> getUserJoinedGrounds(String uid) {
    return _reserve
        .where("collaborations", arrayContains: uid)
        .get()
        .then((value) {
      List<ReserveModel> reservisions = [];
      for (var document in value.docs) {
        reservisions
            .add(ReserveModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return reservisions;
    });
  }

  Future<List<GroundModel>> getUserGrounds(String collection, String groundId) {
    return _firestore
        .collection(collection)
        .where("id", isEqualTo: groundId)
        .get()
        .then((event) {
      List<GroundModel> grounds = [];
      for (var document in event.docs) {
        grounds
            .add(GroundModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return grounds;
    });
  }

  Future<UserModel> getUserData(String userId) {
    return _users.doc(userId).get().then((value) {
      return UserModel.fromMap(value.data() as Map<String, dynamic>);
    });
  }

//inBox
  FutureVoid sendInboxToUser(InBoxModel inBoxModel) async {
    try {
      return right(_inBox.doc(inBoxModel.id).set(inBoxModel.toMap()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<List<InBoxModel>> getInBoxMessages(String userId) {
    return _inBox.get().then((event) {
      List<InBoxModel> inBox = [];
      for (var document in event.docs) {
        inBox.add(InBoxModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return inBox;
    });
  }
}
