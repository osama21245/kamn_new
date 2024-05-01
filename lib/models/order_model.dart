// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  int itemsprice;
  String countitems;
  String cartId;
  String cartUsersid;
  String cartItemid;
  String cartOrders;
  String itemsId;
  String itemsName;
  String itemsNameAr;
  String itemsDescriptiom;
  String itemsDecriptiomAr;
  String itemsCount;
  String itemsActive;
  String itemsPrice;
  int itemsDiscount;
  String itemsDate;
  String itmesCat;
  String itemsImage;
  String ordersId;
  String ordersUsersid;
  String ordersUserName;
  String ordersServiceProviderId;
  String ordersServiceProviderName;
  String ordersType;
  int ordersPricedelivery;
  int ordersTotalprice;
  int ordersPrice;
  String ordersCoupon;
  String ordersAddress;
  String ordersPaymenttype;
  String ordersStatus;
  DateTime ordersDatetime;
  DateTime ordersExpireDatetime;
  String address;
  String mixOrSeparateOrGroupOrPrivet;
  String collection;
  String storeId;
  OrderModel({
    required this.itemsprice,
    required this.countitems,
    required this.cartId,
    required this.cartUsersid,
    required this.cartItemid,
    required this.cartOrders,
    required this.itemsId,
    required this.itemsName,
    required this.itemsNameAr,
    required this.itemsDescriptiom,
    required this.itemsDecriptiomAr,
    required this.itemsCount,
    required this.itemsActive,
    required this.itemsPrice,
    required this.itemsDiscount,
    required this.itemsDate,
    required this.itmesCat,
    required this.itemsImage,
    required this.ordersId,
    required this.ordersUsersid,
    required this.ordersUserName,
    required this.ordersServiceProviderId,
    required this.ordersServiceProviderName,
    required this.ordersType,
    required this.ordersPricedelivery,
    required this.ordersTotalprice,
    required this.ordersPrice,
    required this.ordersCoupon,
    required this.ordersAddress,
    required this.ordersPaymenttype,
    required this.ordersStatus,
    required this.ordersDatetime,
    required this.ordersExpireDatetime,
    required this.address,
    required this.mixOrSeparateOrGroupOrPrivet,
    required this.collection,
    required this.storeId,
  });

  OrderModel copyWith({
    int? itemsprice,
    String? countitems,
    String? cartId,
    String? cartUsersid,
    String? cartItemid,
    String? cartOrders,
    String? itemsId,
    String? itemsName,
    String? itemsNameAr,
    String? itemsDescriptiom,
    String? itemsDecriptiomAr,
    String? itemsCount,
    String? itemsActive,
    String? itemsPrice,
    int? itemsDiscount,
    String? itemsDate,
    String? itmesCat,
    String? itemsImage,
    String? ordersId,
    String? ordersUsersid,
    String? ordersUserName,
    String? ordersServiceProviderId,
    String? ordersServiceProviderName,
    String? ordersType,
    int? ordersPricedelivery,
    int? ordersTotalprice,
    int? ordersPrice,
    String? ordersCoupon,
    String? ordersAddress,
    String? ordersPaymenttype,
    String? ordersStatus,
    DateTime? ordersDatetime,
    DateTime? ordersExpireDatetime,
    String? address,
    String? mixOrSeparateOrGroupOrPrivet,
    String? collection,
    String? storeId,
  }) {
    return OrderModel(
      itemsprice: itemsprice ?? this.itemsprice,
      countitems: countitems ?? this.countitems,
      cartId: cartId ?? this.cartId,
      cartUsersid: cartUsersid ?? this.cartUsersid,
      cartItemid: cartItemid ?? this.cartItemid,
      cartOrders: cartOrders ?? this.cartOrders,
      itemsId: itemsId ?? this.itemsId,
      itemsName: itemsName ?? this.itemsName,
      itemsNameAr: itemsNameAr ?? this.itemsNameAr,
      itemsDescriptiom: itemsDescriptiom ?? this.itemsDescriptiom,
      itemsDecriptiomAr: itemsDecriptiomAr ?? this.itemsDecriptiomAr,
      itemsCount: itemsCount ?? this.itemsCount,
      itemsActive: itemsActive ?? this.itemsActive,
      itemsPrice: itemsPrice ?? this.itemsPrice,
      itemsDiscount: itemsDiscount ?? this.itemsDiscount,
      itemsDate: itemsDate ?? this.itemsDate,
      itmesCat: itmesCat ?? this.itmesCat,
      itemsImage: itemsImage ?? this.itemsImage,
      ordersId: ordersId ?? this.ordersId,
      ordersUsersid: ordersUsersid ?? this.ordersUsersid,
      ordersUserName: ordersUserName ?? this.ordersUserName,
      ordersServiceProviderId:
          ordersServiceProviderId ?? this.ordersServiceProviderId,
      ordersServiceProviderName:
          ordersServiceProviderName ?? this.ordersServiceProviderName,
      ordersType: ordersType ?? this.ordersType,
      ordersPricedelivery: ordersPricedelivery ?? this.ordersPricedelivery,
      ordersTotalprice: ordersTotalprice ?? this.ordersTotalprice,
      ordersPrice: ordersPrice ?? this.ordersPrice,
      ordersCoupon: ordersCoupon ?? this.ordersCoupon,
      ordersAddress: ordersAddress ?? this.ordersAddress,
      ordersPaymenttype: ordersPaymenttype ?? this.ordersPaymenttype,
      ordersStatus: ordersStatus ?? this.ordersStatus,
      ordersDatetime: ordersDatetime ?? this.ordersDatetime,
      ordersExpireDatetime: ordersExpireDatetime ?? this.ordersExpireDatetime,
      address: address ?? this.address,
      mixOrSeparateOrGroupOrPrivet:
          mixOrSeparateOrGroupOrPrivet ?? this.mixOrSeparateOrGroupOrPrivet,
      collection: collection ?? this.collection,
      storeId: storeId ?? this.storeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemsprice': itemsprice,
      'countitems': countitems,
      'cartId': cartId,
      'cartUsersid': cartUsersid,
      'cartItemid': cartItemid,
      'cartOrders': cartOrders,
      'itemsId': itemsId,
      'itemsName': itemsName,
      'itemsNameAr': itemsNameAr,
      'itemsDescriptiom': itemsDescriptiom,
      'itemsDecriptiomAr': itemsDecriptiomAr,
      'itemsCount': itemsCount,
      'itemsActive': itemsActive,
      'itemsPrice': itemsPrice,
      'itemsDiscount': itemsDiscount,
      'itemsDate': itemsDate,
      'itmesCat': itmesCat,
      'itemsImage': itemsImage,
      'ordersId': ordersId,
      'ordersUsersid': ordersUsersid,
      'ordersUserName': ordersUserName,
      'ordersServiceProviderId': ordersServiceProviderId,
      'ordersServiceProviderName': ordersServiceProviderName,
      'ordersType': ordersType,
      'ordersPricedelivery': ordersPricedelivery,
      'ordersTotalprice': ordersTotalprice,
      'ordersPrice': ordersPrice,
      'ordersCoupon': ordersCoupon,
      'ordersAddress': ordersAddress,
      'ordersPaymenttype': ordersPaymenttype,
      'ordersStatus': ordersStatus,
      'ordersDatetime': ordersDatetime.millisecondsSinceEpoch,
      'ordersExpireDatetime': ordersExpireDatetime.millisecondsSinceEpoch,
      'address': address,
      'mixOrSeparateOrGroupOrPrivet': mixOrSeparateOrGroupOrPrivet,
      'collection': collection,
      'storeId': storeId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      itemsprice: map['itemsprice'] as int,
      countitems: map['countitems'] as String,
      cartId: map['cartId'] as String,
      cartUsersid: map['cartUsersid'] as String,
      cartItemid: map['cartItemid'] as String,
      cartOrders: map['cartOrders'] as String,
      itemsId: map['itemsId'] as String,
      itemsName: map['itemsName'] as String,
      itemsNameAr: map['itemsNameAr'] as String,
      itemsDescriptiom: map['itemsDescriptiom'] as String,
      itemsDecriptiomAr: map['itemsDecriptiomAr'] as String,
      itemsCount: map['itemsCount'] as String,
      itemsActive: map['itemsActive'] as String,
      itemsPrice: map['itemsPrice'] as String,
      itemsDiscount: map['itemsDiscount'] as int,
      itemsDate: map['itemsDate'] as String,
      itmesCat: map['itmesCat'] as String,
      itemsImage: map['itemsImage'] as String,
      ordersId: map['ordersId'] as String,
      ordersUsersid: map['ordersUsersid'] as String,
      ordersUserName: map['ordersUserName'] as String,
      ordersServiceProviderId: map['ordersServiceProviderId'] as String,
      ordersServiceProviderName: map['ordersServiceProviderName'] as String,
      ordersType: map['ordersType'] as String,
      ordersPricedelivery: map['ordersPricedelivery'] as int,
      ordersTotalprice: map['ordersTotalprice'] as int,
      ordersPrice: map['ordersPrice'] as int,
      ordersCoupon: map['ordersCoupon'] as String,
      ordersAddress: map['ordersAddress'] as String,
      ordersPaymenttype: map['ordersPaymenttype'] as String,
      ordersStatus: map['ordersStatus'] as String,
      ordersDatetime:
          DateTime.fromMillisecondsSinceEpoch(map['ordersDatetime'] as int),
      ordersExpireDatetime: DateTime.fromMillisecondsSinceEpoch(
          map['ordersExpireDatetime'] as int),
      address: map['address'] as String,
      mixOrSeparateOrGroupOrPrivet:
          map['mixOrSeparateOrGroupOrPrivet'] as String,
      collection: map['collection'] as String,
      storeId: map['storeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(itemsprice: $itemsprice, countitems: $countitems, cartId: $cartId, cartUsersid: $cartUsersid, cartItemid: $cartItemid, cartOrders: $cartOrders, itemsId: $itemsId, itemsName: $itemsName, itemsNameAr: $itemsNameAr, itemsDescriptiom: $itemsDescriptiom, itemsDecriptiomAr: $itemsDecriptiomAr, itemsCount: $itemsCount, itemsActive: $itemsActive, itemsPrice: $itemsPrice, itemsDiscount: $itemsDiscount, itemsDate: $itemsDate, itmesCat: $itmesCat, itemsImage: $itemsImage, ordersId: $ordersId, ordersUsersid: $ordersUsersid, ordersUserName: $ordersUserName, ordersServiceProviderId: $ordersServiceProviderId, ordersServiceProviderName: $ordersServiceProviderName, ordersType: $ordersType, ordersPricedelivery: $ordersPricedelivery, ordersTotalprice: $ordersTotalprice, ordersPrice: $ordersPrice, ordersCoupon: $ordersCoupon, ordersAddress: $ordersAddress, ordersPaymenttype: $ordersPaymenttype, ordersStatus: $ordersStatus, ordersDatetime: $ordersDatetime, ordersExpireDatetime: $ordersExpireDatetime, address: $address, mixOrSeparateOrGroupOrPrivet: $mixOrSeparateOrGroupOrPrivet, collection: $collection, storeId: $storeId)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.itemsprice == itemsprice &&
        other.countitems == countitems &&
        other.cartId == cartId &&
        other.cartUsersid == cartUsersid &&
        other.cartItemid == cartItemid &&
        other.cartOrders == cartOrders &&
        other.itemsId == itemsId &&
        other.itemsName == itemsName &&
        other.itemsNameAr == itemsNameAr &&
        other.itemsDescriptiom == itemsDescriptiom &&
        other.itemsDecriptiomAr == itemsDecriptiomAr &&
        other.itemsCount == itemsCount &&
        other.itemsActive == itemsActive &&
        other.itemsPrice == itemsPrice &&
        other.itemsDiscount == itemsDiscount &&
        other.itemsDate == itemsDate &&
        other.itmesCat == itmesCat &&
        other.itemsImage == itemsImage &&
        other.ordersId == ordersId &&
        other.ordersUsersid == ordersUsersid &&
        other.ordersUserName == ordersUserName &&
        other.ordersServiceProviderId == ordersServiceProviderId &&
        other.ordersServiceProviderName == ordersServiceProviderName &&
        other.ordersType == ordersType &&
        other.ordersPricedelivery == ordersPricedelivery &&
        other.ordersTotalprice == ordersTotalprice &&
        other.ordersPrice == ordersPrice &&
        other.ordersCoupon == ordersCoupon &&
        other.ordersAddress == ordersAddress &&
        other.ordersPaymenttype == ordersPaymenttype &&
        other.ordersStatus == ordersStatus &&
        other.ordersDatetime == ordersDatetime &&
        other.ordersExpireDatetime == ordersExpireDatetime &&
        other.address == address &&
        other.mixOrSeparateOrGroupOrPrivet == mixOrSeparateOrGroupOrPrivet &&
        other.collection == collection &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    return itemsprice.hashCode ^
        countitems.hashCode ^
        cartId.hashCode ^
        cartUsersid.hashCode ^
        cartItemid.hashCode ^
        cartOrders.hashCode ^
        itemsId.hashCode ^
        itemsName.hashCode ^
        itemsNameAr.hashCode ^
        itemsDescriptiom.hashCode ^
        itemsDecriptiomAr.hashCode ^
        itemsCount.hashCode ^
        itemsActive.hashCode ^
        itemsPrice.hashCode ^
        itemsDiscount.hashCode ^
        itemsDate.hashCode ^
        itmesCat.hashCode ^
        itemsImage.hashCode ^
        ordersId.hashCode ^
        ordersUsersid.hashCode ^
        ordersUserName.hashCode ^
        ordersServiceProviderId.hashCode ^
        ordersServiceProviderName.hashCode ^
        ordersType.hashCode ^
        ordersPricedelivery.hashCode ^
        ordersTotalprice.hashCode ^
        ordersPrice.hashCode ^
        ordersCoupon.hashCode ^
        ordersAddress.hashCode ^
        ordersPaymenttype.hashCode ^
        ordersStatus.hashCode ^
        ordersDatetime.hashCode ^
        ordersExpireDatetime.hashCode ^
        address.hashCode ^
        mixOrSeparateOrGroupOrPrivet.hashCode ^
        collection.hashCode ^
        storeId.hashCode;
  }
}
