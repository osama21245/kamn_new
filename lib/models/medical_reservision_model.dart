// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MedicalReservisionModel {
  String ordersId;
  String ordersUserid;
  String ordername;
  String orderdiscount;
  String orderdescription;
  String ordersServiceProviderName;
  String ordersServiceProviderId;
  String storeId;
  bool orderisSure;
  int ordersTotalprice;
  String ordersPaymenttype;
  DateTime ordersDatetime;
  String serviceId;
  String price;
  String discount;
  String day;
  String address;
  String collection;
  MedicalReservisionModel({
    required this.ordersId,
    required this.ordersUserid,
    required this.ordername,
    required this.orderdiscount,
    required this.orderdescription,
    required this.ordersServiceProviderName,
    required this.ordersServiceProviderId,
    required this.storeId,
    required this.orderisSure,
    required this.ordersTotalprice,
    required this.ordersPaymenttype,
    required this.ordersDatetime,
    required this.serviceId,
    required this.price,
    required this.discount,
    required this.day,
    required this.address,
    required this.collection,
  });

  MedicalReservisionModel copyWith({
    String? ordersId,
    String? ordersUserid,
    String? ordername,
    String? orderdiscount,
    String? orderdescription,
    String? ordersServiceProviderName,
    String? ordersServiceProviderId,
    String? storeId,
    bool? orderisSure,
    int? ordersTotalprice,
    String? ordersPaymenttype,
    DateTime? ordersDatetime,
    String? serviceId,
    String? price,
    String? discount,
    String? day,
    String? address,
    String? collection,
  }) {
    return MedicalReservisionModel(
      ordersId: ordersId ?? this.ordersId,
      ordersUserid: ordersUserid ?? this.ordersUserid,
      ordername: ordername ?? this.ordername,
      orderdiscount: orderdiscount ?? this.orderdiscount,
      orderdescription: orderdescription ?? this.orderdescription,
      ordersServiceProviderName:
          ordersServiceProviderName ?? this.ordersServiceProviderName,
      ordersServiceProviderId:
          ordersServiceProviderId ?? this.ordersServiceProviderId,
      storeId: storeId ?? this.storeId,
      orderisSure: orderisSure ?? this.orderisSure,
      ordersTotalprice: ordersTotalprice ?? this.ordersTotalprice,
      ordersPaymenttype: ordersPaymenttype ?? this.ordersPaymenttype,
      ordersDatetime: ordersDatetime ?? this.ordersDatetime,
      serviceId: serviceId ?? this.serviceId,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      day: day ?? this.day,
      address: address ?? this.address,
      collection: collection ?? this.collection,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ordersId': ordersId,
      'ordersUserid': ordersUserid,
      'ordername': ordername,
      'orderdiscount': orderdiscount,
      'orderdescription': orderdescription,
      'ordersServiceProviderName': ordersServiceProviderName,
      'ordersServiceProviderId': ordersServiceProviderId,
      'storeId': storeId,
      'orderisSure': orderisSure,
      'ordersTotalprice': ordersTotalprice,
      'ordersPaymenttype': ordersPaymenttype,
      'ordersDatetime': ordersDatetime.millisecondsSinceEpoch,
      'serviceId': serviceId,
      'price': price,
      'discount': discount,
      'day': day,
      'address': address,
      'collection': collection,
    };
  }

  factory MedicalReservisionModel.fromMap(Map<String, dynamic> map) {
    return MedicalReservisionModel(
      ordersId: map['ordersId'] as String,
      ordersUserid: map['ordersUserid'] as String,
      ordername: map['ordername'] as String,
      orderdiscount: map['orderdiscount'] as String,
      orderdescription: map['orderdescription'] as String,
      ordersServiceProviderName: map['ordersServiceProviderName'] as String,
      ordersServiceProviderId: map['ordersServiceProviderId'] as String,
      storeId: map['storeId'] as String,
      orderisSure: map['orderisSure'] as bool,
      ordersTotalprice: map['ordersTotalprice'] as int,
      ordersPaymenttype: map['ordersPaymenttype'] as String,
      ordersDatetime:
          DateTime.fromMillisecondsSinceEpoch(map['ordersDatetime'] as int),
      serviceId: map['serviceId'] as String,
      price: map['price'] as String,
      discount: map['discount'] as String,
      day: map['day'] as String,
      address: map['address'] as String,
      collection: map['collection'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalReservisionModel.fromJson(String source) =>
      MedicalReservisionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MedicalReservisionModel(ordersId: $ordersId, ordersUserid: $ordersUserid, ordername: $ordername, orderdiscount: $orderdiscount, orderdescription: $orderdescription, ordersServiceProviderName: $ordersServiceProviderName, ordersServiceProviderId: $ordersServiceProviderId, storeId: $storeId, orderisSure: $orderisSure, ordersTotalprice: $ordersTotalprice, ordersPaymenttype: $ordersPaymenttype, ordersDatetime: $ordersDatetime, serviceId: $serviceId, price: $price, discount: $discount, day: $day, address: $address, collection: $collection)';
  }

  @override
  bool operator ==(covariant MedicalReservisionModel other) {
    if (identical(this, other)) return true;

    return other.ordersId == ordersId &&
        other.ordersUserid == ordersUserid &&
        other.ordername == ordername &&
        other.orderdiscount == orderdiscount &&
        other.orderdescription == orderdescription &&
        other.ordersServiceProviderName == ordersServiceProviderName &&
        other.ordersServiceProviderId == ordersServiceProviderId &&
        other.storeId == storeId &&
        other.orderisSure == orderisSure &&
        other.ordersTotalprice == ordersTotalprice &&
        other.ordersPaymenttype == ordersPaymenttype &&
        other.ordersDatetime == ordersDatetime &&
        other.serviceId == serviceId &&
        other.price == price &&
        other.discount == discount &&
        other.day == day &&
        other.address == address &&
        other.collection == collection;
  }

  @override
  int get hashCode {
    return ordersId.hashCode ^
        ordersUserid.hashCode ^
        ordername.hashCode ^
        orderdiscount.hashCode ^
        orderdescription.hashCode ^
        ordersServiceProviderName.hashCode ^
        ordersServiceProviderId.hashCode ^
        storeId.hashCode ^
        orderisSure.hashCode ^
        ordersTotalprice.hashCode ^
        ordersPaymenttype.hashCode ^
        ordersDatetime.hashCode ^
        serviceId.hashCode ^
        price.hashCode ^
        discount.hashCode ^
        day.hashCode ^
        address.hashCode ^
        collection.hashCode;
  }
}
