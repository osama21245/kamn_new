import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/core/faliure.dart';
import 'package:kman/core/providers/firebase_providers.dart';
import 'package:kman/core/type_def.dart';

import 'package:kman/models/order_model.dart';
import 'package:kman/models/qr_order_model.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/data/notfication_data.dart';
import '../../../core/data/review_data.dart';
import '../../../core/providers/handlingdata.dart';
import '../../../models/medical_reservision_model.dart';

final OrdersRepositoryProvider = Provider(
    (ref) => OrdersRepository(firestore: ref.watch(FirestoreProvider)));

class OrdersRepository {
  final FirebaseFirestore _firestore;

  OrdersRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _orders => _firestore.collection("orders");
  CollectionReference get _medicalReservisions =>
      _firestore.collection("medical_Reservisions");
  CollectionReference get _qrOrders => _firestore.collection("qrOrders");
  NotficationData notificationData = NotficationData(Get.find());
  ReviewData reviewData = ReviewData(Get.find());

  Stream<List<OrderModel>> getModOrders(String serviceProviderId) {
    return _orders
        .where("ordersServiceProviderId", isEqualTo: serviceProviderId)
        .snapshots()
        .map((value) {
      List<OrderModel> orders = [];
      for (var document in value.docs) {
        orders.add(OrderModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return orders;
    });
  }

  Stream<List<OrderModel>> getUserGymReservisions(
    String userId,
  ) {
    // that Fun also can work as (getServiceProviderMyOrders)
    return _orders
        .where("ordersUsersid", isEqualTo: userId)
        .where("collection", isEqualTo: Collections.gymCollection)
        .snapshots()
        .map((value) {
      List<OrderModel> orders = [];
      for (var document in value.docs) {
        orders.add(OrderModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return orders;
    });
  }

  Stream<List<OrderModel>> getUsercoachesReservisions(String userId) {
    // that Fun also can work as (getServiceProviderMyOrders)
    return _orders
        .where("ordersUsersid", isEqualTo: userId)
        .where("collection", isEqualTo: Collections.coachCollection)
        .snapshots()
        .map((value) {
      List<OrderModel> orders = [];
      for (var document in value.docs) {
        orders.add(OrderModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return orders;
    });
  }

  Stream<List<MedicalReservisionModel>> getMedicalReservisions(String userId) {
    // that Fun also can work as (getServiceProviderMyOrders)
    return _medicalReservisions
        .where("ordersUserid", isEqualTo: userId)
        .where("orderisSure", isEqualTo: false)
        .snapshots()
        .map((value) {
      List<MedicalReservisionModel> orders = [];
      for (var document in value.docs) {
        orders.add(MedicalReservisionModel.fromMap(
            document.data() as Map<String, dynamic>));
      }
      return orders;
    });
  }

  Stream<List<OrderModel>> getServiceProviderRecivedOrders(
      String serviceProviderId, String storeId) {
    // in this case service provider id is the userId because he will open the orders from his account and already his id linked with the service providerpage the user take the order from
    return _orders
        .where("ordersServiceProviderId", isEqualTo: serviceProviderId)
        .where("storeId", isEqualTo: storeId)
        .snapshots()
        .map((value) {
      List<OrderModel> orders = [];
      for (var document in value.docs) {
        orders.add(OrderModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return orders;
    });
  }

  Future<Either<Failure, dynamic>> pushOrderNotification(
      String title, String body, String topic) async {
    try {
      var response =
          await notificationData.pushNotifications(title, body, topic);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setOrder(OrderModel orderModel) async {
    try {
      return right(_orders.doc(orderModel.ordersId).set(orderModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setMedicalReservision(
      MedicalReservisionModel medicalReservisionModel) async {
    try {
      return right(_medicalReservisions
          .doc(medicalReservisionModel.ordersId)
          .set(medicalReservisionModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid SureMedicalReservision(
      String medicalReservisionId, String price) async {
    try {
      return right(_medicalReservisions
          .doc(medicalReservisionId)
          .update({"orderisSure": true, "price": price}));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid cancleMedicalReservision(String medicalReservisionId) async {
    try {
      return right(_medicalReservisions.doc(medicalReservisionId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteOrder(String orderId) async {
    try {
      return right(_orders.doc(orderId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteQrOrder(String orderId) async {
    try {
      return right(_firestore.collection("qrOrders").doc(orderId).delete());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid setQrOrder(QrOrderModel qrorderModel, String storeId) async {
    try {
      return right(_firestore
          .collection("qrOrders")
          .doc(qrorderModel.orderid)
          .set(qrorderModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid rateItem(String serviceProviderId, String userId, String comment,
      String rating) async {
    try {
      var response = await reviewData.addreviews(
          serviceProviderId.toString(), userId, comment, rating);
      //    rating == null ? "0" : rating);
      var statusRequest = StatusRequest.success;
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        return right(response);
      } else {
        throw "serverFail";
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<QrOrderModel>> getuserQrOrder(
      String userId, String sportsStoreId) {
    return _qrOrders
        .where("userId", isEqualTo: userId)
        .where("storeId", isEqualTo: sportsStoreId)
        .snapshots()
        .map((event) {
      List<QrOrderModel> medicals = [];
      for (var community in event.docs) {
        medicals.add(
            QrOrderModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  Stream<List<QrOrderModel>> getSportsQrOrder(
    String userId,
  ) {
    return _qrOrders
        .where("userId", isEqualTo: userId)
        .where("category", isEqualTo: Collections.sportsCollection)
        .snapshots()
        .map((event) {
      List<QrOrderModel> medicals = [];
      for (var community in event.docs) {
        medicals.add(
            QrOrderModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  Stream<List<QrOrderModel>> getNutritionQrOrder(
    String userId,
  ) {
    return _qrOrders
        .where("userId", isEqualTo: userId)
        .where("category", isEqualTo: Collections.nutritionCollection)
        .snapshots()
        .map((event) {
      List<QrOrderModel> medicals = [];
      for (var community in event.docs) {
        medicals.add(
            QrOrderModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  //*************************serice provider *********************/

  Stream<List<QrOrderModel>> getServiceProviderNutritionQrOrder(
    String userId,
  ) {
    return _qrOrders
        .where("serviceProviderId", isEqualTo: userId)
        .where("category", isEqualTo: Collections.nutritionCollection)
        .snapshots()
        .map((event) {
      List<QrOrderModel> medicals = [];
      for (var community in event.docs) {
        medicals.add(
            QrOrderModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }

  Stream<List<QrOrderModel>> getServiceProviderSportsQrOrder(
      String userId, String storeId) {
    return _qrOrders
        .where("serviceProviderId", isEqualTo: userId)
        .where("category", isEqualTo: Collections.sportsCollection)
        .where("storeId", isEqualTo: storeId)
        .snapshots()
        .map((event) {
      List<QrOrderModel> medicals = [];
      for (var community in event.docs) {
        medicals.add(
            QrOrderModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return medicals;
    });
  }
}
