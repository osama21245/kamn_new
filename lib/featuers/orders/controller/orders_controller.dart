import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/models/medical_reservision_model.dart';
import 'package:kman/models/order_model.dart';
import 'package:kman/models/qr_order_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/storage_repository.dart';
import '../../../core/providers/utils.dart';
import '../../../models/offers_items_model.dart';
import '../../../models/offers_model.dart';
import '../repositories/orders_repository.dart';
import 'package:get/get.dart';

import '../screens/my_reservisions_screens.dart';

final getModOrdersProvider = StreamProvider.autoDispose.family(
    (ref, String serviceProviderId) => ref
        .watch(ordersControllerProvider.notifier)
        .getModOrders(serviceProviderId));

final getUserGymReservisionsProvider = StreamProvider.autoDispose.family(
    (ref, String userid) => ref
        .watch(ordersControllerProvider.notifier)
        .getUserGymReservisions(userid));

final getUsercoachesReservisionsProvider = StreamProvider.autoDispose.family(
    (ref, String userid) => ref
        .watch(ordersControllerProvider.notifier)
        .getUsercoachesReservisions(userid));

final getUserMedicalReservisionProvider = StreamProvider.autoDispose.family(
    (ref, String userid) => ref
        .watch(ordersControllerProvider.notifier)
        .getUserMedicalReservision(userid));
//
final getServiceProviderRecivedOrdersProvider =
    StreamProvider.autoDispose.family((ref, Tuple2 tuple) {
  final userId = tuple.value1;
  final storeId = tuple.value2;
  final repo = ref
      .watch(ordersControllerProvider.notifier)
      .getServiceProviderRecivedOrders(userId, storeId);
  return repo;
});

final getQrOrdersProvider = StreamProvider.autoDispose
    .family<List<QrOrderModel>, Tuple2<String, String>>((ref, tuple) {
  final userId = tuple.value1;
  final storeId = tuple.value2;
  final repository = ref.watch(ordersControllerProvider.notifier);
  return repository.getQrOrder(userId, storeId);
});

final getSportsQrOrdersProvider =
    StreamProvider.autoDispose.family((ref, String userId) {
  final repository = ref.watch(ordersControllerProvider.notifier);
  return repository.getSportsQrOrder(userId);
});

final getNutritionQrOrdersProvider =
    StreamProvider.autoDispose.family((ref, String userId) {
  final repository = ref.watch(ordersControllerProvider.notifier);
  return repository.getNutritionQrOrder(userId);
});

//*************************service provider***************** */

final getServiceProviderSportsQrOrderProvider = StreamProvider.autoDispose
    .family<List<QrOrderModel>, Tuple2<String, String>>((ref, tuple) {
  final userId = tuple.value1;
  final storeId = tuple.value2;
  final repository = ref.watch(ordersControllerProvider.notifier);
  return repository.getServiceProviderSportsQrOrder(userId, storeId);
});

final getServiceProviderNutritionQrOrdersProvider =
    StreamProvider.autoDispose.family((ref, String userId) {
  final repository = ref.watch(ordersControllerProvider.notifier);
  return repository.getServiceProviderNutritionQrOrder(userId);
});

//*************************************************************** */

final ordersControllerProvider =
    StateNotifierProvider<OrdersController, StatusRequest>((ref) =>
        OrdersController(
            storageRepository: ref.watch(storageRepositoryProvider),
            ordersRepository: ref.watch(OrdersRepositoryProvider),
            ref: ref));

class OrdersController extends StateNotifier<StatusRequest> {
  final Ref _ref;
  final OrdersRepository _ordersRepository;
  final StorageRepository _storageRepository;
  bool takeQrDiscount = false;

  OrdersController(
      {required OrdersRepository ordersRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _ordersRepository = ordersRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(StatusRequest.success);

  // double rating = 0;

  Stream<List<OrderModel>> getModOrders(String serviceProviderId) {
    return _ordersRepository.getModOrders(serviceProviderId);
  }

  Stream<List<OrderModel>> getUserGymReservisions(String userid) {
    return _ordersRepository.getUserGymReservisions(userid);
  }

  Stream<List<OrderModel>> getUsercoachesReservisions(String userid) {
    return _ordersRepository.getUsercoachesReservisions(userid);
  }

  Stream<List<MedicalReservisionModel>> getUserMedicalReservision(
      String userid) {
    return _ordersRepository.getMedicalReservisions(userid);
  }

  Stream<List<OrderModel>> getServiceProviderRecivedOrders(
      String userid, String storeId) {
    return _ordersRepository.getServiceProviderRecivedOrders(userid, storeId);
  }

  Stream<List<QrOrderModel>> getQrOrder(String userid, String storeId) {
    return _ordersRepository.getuserQrOrder(userid, storeId);
  }

  Stream<List<QrOrderModel>> getSportsQrOrder(
    String userid,
  ) {
    return _ordersRepository.getSportsQrOrder(
      userid,
    );
  }

  Stream<List<QrOrderModel>> getNutritionQrOrder(
    String userid,
  ) {
    return _ordersRepository.getNutritionQrOrder(userid);
  }

  //***********************service Provider *******************/

  Stream<List<QrOrderModel>> getServiceProviderSportsQrOrder(
      String userid, String storeId) {
    return _ordersRepository.getServiceProviderSportsQrOrder(userid, storeId);
  }

  Stream<List<QrOrderModel>> getServiceProviderNutritionQrOrder(
    String userid,
  ) {
    return _ordersRepository.getServiceProviderNutritionQrOrder(userid);
  }

//**************************************************************** */
  void deleteOrder(String orderId, BuildContext context) async {
    final res = await _ordersRepository.deleteOrder(orderId);
    res.fold((l) => showSnackBar(l.message, context), (r) {
      showSnackBar("Your order has been deleted", context);
      Get.back();
    });
  }

  void deleteQrOrder(String orderId, BuildContext context) async {
    final res = await _ordersRepository.deleteQrOrder(orderId);
    res.fold((l) => showSnackBar(l.message, context), (r) {
      showSnackBar("Your order has been deleted", context);
      Get.back();
    });
  }

  void setOrder(
      BuildContext context,
      int discount,
      int totalPrice,
      String paymentType,
      String serviceProviderId,
      String serviceProviderName,
      int price,
      String orderName,
      String orderDescription,
      String mixOrSeparateOrGroupOrPrivet,
      String collection,
      String storeId,
      // the expiretion data is the data that the reservision of the gym end at or it can be a dynamic details of coach reservision times
      String expretionDate) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final user = _ref.watch(usersProvider);

//set data

    OrderModel orderModel = OrderModel(
        storeId: storeId,
        itemsprice: 0,
        countitems: "0",
        cartId: "",
        cartUsersid: "",
        cartItemid: "",
        cartOrders: "",
        itemsId: "",
        itemsName: orderName,
        itemsNameAr: "",
        itemsDescriptiom: orderDescription,
        itemsDecriptiomAr: "",
        itemsCount: "",
        itemsActive: "",
        itemsPrice: "",
        itemsDiscount: discount,
        itemsDate: collection == "coach" ? expretionDate : "",
        itmesCat: "",
        itemsImage: "",
        ordersId: id,
        ordersUsersid: user!.uid,
        ordersUserName: user.name,
        ordersServiceProviderId: serviceProviderId,
        ordersServiceProviderName: serviceProviderName,
        ordersType: "",
        ordersPricedelivery: 0,
        ordersTotalprice: totalPrice,
        ordersPrice: price,
        ordersCoupon: "",
        ordersAddress: "",
        ordersPaymenttype: paymentType,
        ordersStatus: "Successful",
        ordersDatetime: DateTime.now(),
        ordersExpireDatetime: collection == "gym"
            ? DateTime.now().add(Duration(days: int.parse(expretionDate) * 30))
            : DateTime.now(),
        address: "",
        mixOrSeparateOrGroupOrPrivet: mixOrSeparateOrGroupOrPrivet,
        collection: collection);

    final res = await _ordersRepository.setOrder(orderModel);
    state = StatusRequest.success;

    res.fold((l) => showSnackBar(l.toString(), context), (r) async {
      if (collection == "coach") {
        await _ordersRepository.pushOrderNotification("New customer",
            "You have a new reservision", "users${serviceProviderId}");
      } else if (collection == "gym") {
        _ordersRepository.pushOrderNotification("New reservision",
            "You have a new reservision", "users${serviceProviderId}");
      } else {
        await _ordersRepository.pushOrderNotification(
            "New order", "You have a new order", "users${serviceProviderId}");
      }
      showSnackBar("Your order Added Succefuly", context);
      await Future.delayed(const Duration(seconds: 5)).then((value) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MyReservisionsScreens()));
      });
    });
  }

  void setMedicalReservision(
      String title,
      String disount,
      String description,
      String day,
      String orderPaymentTyoe,
      String seviceProviderId,
      String serviceProviderName,
      String serviceId,
      String address,
      String discount,
      int price,
      String storeId,
      BuildContext context) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final user = _ref.watch(usersProvider);

    MedicalReservisionModel medicalReservisionModel = MedicalReservisionModel(
        discount: discount,
        price: "",
        serviceId: serviceId,
        storeId: storeId,
        orderisSure: false,
        ordersId: id,
        ordersUserid: user!.uid,
        ordername: title,
        orderdiscount: disount,
        orderdescription: description,
        ordersServiceProviderName: serviceProviderName,
        ordersServiceProviderId: seviceProviderId,
        ordersTotalprice: price,
        ordersPaymenttype: orderPaymentTyoe,
        ordersDatetime: DateTime.now(),
        day: day,
        address: address,
        collection: "medical");

    final res =
        await _ordersRepository.setMedicalReservision(medicalReservisionModel);
    res.fold((l) => showSnackBar(l.message, context), (r) {
      _ordersRepository.pushOrderNotification("New reservision",
          "You have a new reservision", "users${seviceProviderId}");
      showSnackBar("you have successfully made the reservation", context);
    });
  }

  void sureMedicalReservision(
      String medicalReservisionId, String price, BuildContext context) async {
    final res = await _ordersRepository.SureMedicalReservision(
        medicalReservisionId, price);
    res.fold((l) => showSnackBar(l.message, context), (r) {
      showSnackBar("you have successfully sure your reservation", context);
    });
  }

  void cancleMedicalReservision(
      String medicalReservisionId, BuildContext context) async {
    final res =
        await _ordersRepository.cancleMedicalReservision(medicalReservisionId);
    res.fold(
        (l) => showSnackBar(l.message, context),
        (r) => showSnackBar(
            "you have successfully cancle your reservation", context));
  }

  void setQrOrder(
    BuildContext context,
    String storeId,
    String serviceProviderId,
    String qrLink,
    OffersModel offerModel,
    String category,
    Size size,
  ) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final userid = _ref.watch(usersProvider)!.uid;

    // Check if the context is not null before proceeding
    if (context != null) {
      //set data
      QrOrderModel qrOrderModel = QrOrderModel(
        orderid: id,
        storeId: storeId,
        image: offerModel.image,
        category: category,
        offerDescription: offerModel.description,
        offerDiscount: offerModel.discount,
        offerPrice: "Public Offer",
        offerTitle: offerModel.title,
        offerId: offerModel.id,
        date: DateTime.now(),
        userId: userid,
        serviceProviderId: serviceProviderId,
        qrLink: qrLink,
      );

      final res = await _ordersRepository.setQrOrder(qrOrderModel, storeId);
      state = StatusRequest.success;

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        takeQrDiscount = true;
      });
    } else {
      // Handle the case where context is null (e.g., log an error, show a default message)
      print("Error: Context is null.");
      // You might want to display an error message to the user
      // or handle it in any other appropriate way for your application
    }
  }

  void setQrOrderItem(
    BuildContext context,
    String storeId,
    String serviceProviderId,
    String qrLink,
    String offerImage,
    String offerTitle,
    String offerPrice,
    String offerDiscount,
    String offerId,
    String category,
  ) async {
    state = StatusRequest.loading;
    String id = Uuid().v1();
    final userid = _ref.watch(usersProvider)!.uid;

    // Check if the context is not null before proceeding
    if (context != null) {
      //set data
      QrOrderModel qrOrderModel = QrOrderModel(
        orderid: id,
        image: offerImage,
        category: category,
        storeId: storeId,
        offerDescription: "Enjoy our special offers from kamn",
        offerDiscount: offerDiscount,
        offerPrice: offerPrice,
        offerTitle: offerTitle,
        offerId: offerId,
        date: DateTime.now(),
        userId: userid,
        serviceProviderId: serviceProviderId,
        qrLink: qrLink,
      );

      final res = await _ordersRepository.setQrOrder(qrOrderModel, storeId);
      state = StatusRequest.success;

      res.fold((l) => showSnackBar(l.toString(), context), (r) {
        takeQrDiscount = true;
      });
    } else {
      // Handle the case where context is null (e.g., log an error, show a default message)
      print("Error: Context is null.");
      // You might want to display an error message to the user
      // or handle it in any other appropriate way for your application
    }
  }

  void rateItem(String serviceProviderId, String comment, BuildContext context,
      double rating) async {
    state = StatusRequest.loading;
    final user = _ref.watch(usersProvider);
    final res = await _ordersRepository.rateItem(
        serviceProviderId, user!.uid, comment, rating.toString());
    state = StatusRequest.success;
    res.fold((l) => showSnackBar(l.message, context),
        (r) => showSnackBar("Thank your for your review", context));
  }
}
