// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PassOrderModel {
  final int discount;
  final int totalPrice;
  final int price;
  final String seviceProviderId;
  final String serviceProviderName;
  final String ordername;
  final String orderDescription;
  final String mixOrSeparateOrGroupOrPrivet;
  final String orderplanTime;
  final String storeId;
  PassOrderModel({
    required this.discount,
    required this.totalPrice,
    required this.price,
    required this.seviceProviderId,
    required this.serviceProviderName,
    required this.ordername,
    required this.orderDescription,
    required this.mixOrSeparateOrGroupOrPrivet,
    required this.orderplanTime,
    required this.storeId,
  });

  PassOrderModel copyWith({
    int? discount,
    int? totalPrice,
    int? price,
    String? seviceProviderId,
    String? serviceProviderName,
    String? ordername,
    String? orderDescription,
    String? mixOrSeparateOrGroupOrPrivet,
    String? orderplanTime,
    String? storeId,
  }) {
    return PassOrderModel(
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      price: price ?? this.price,
      seviceProviderId: seviceProviderId ?? this.seviceProviderId,
      serviceProviderName: serviceProviderName ?? this.serviceProviderName,
      ordername: ordername ?? this.ordername,
      orderDescription: orderDescription ?? this.orderDescription,
      mixOrSeparateOrGroupOrPrivet:
          mixOrSeparateOrGroupOrPrivet ?? this.mixOrSeparateOrGroupOrPrivet,
      orderplanTime: orderplanTime ?? this.orderplanTime,
      storeId: storeId ?? this.storeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'discount': discount,
      'totalPrice': totalPrice,
      'price': price,
      'seviceProviderId': seviceProviderId,
      'serviceProviderName': serviceProviderName,
      'ordername': ordername,
      'orderDescription': orderDescription,
      'mixOrSeparateOrGroupOrPrivet': mixOrSeparateOrGroupOrPrivet,
      'orderplanTime': orderplanTime,
      'storeId': storeId,
    };
  }

  factory PassOrderModel.fromMap(Map<String, dynamic> map) {
    return PassOrderModel(
      discount: map['discount'] as int,
      totalPrice: map['totalPrice'] as int,
      price: map['price'] as int,
      seviceProviderId: map['seviceProviderId'] as String,
      serviceProviderName: map['serviceProviderName'] as String,
      ordername: map['ordername'] as String,
      orderDescription: map['orderDescription'] as String,
      mixOrSeparateOrGroupOrPrivet:
          map['mixOrSeparateOrGroupOrPrivet'] as String,
      orderplanTime: map['orderplanTime'] as String,
      storeId: map['storeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PassOrderModel.fromJson(String source) =>
      PassOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PassOrderModel(discount: $discount, totalPrice: $totalPrice, price: $price, seviceProviderId: $seviceProviderId, serviceProviderName: $serviceProviderName, ordername: $ordername, orderDescription: $orderDescription, mixOrSeparateOrGroupOrPrivet: $mixOrSeparateOrGroupOrPrivet, orderplanTime: $orderplanTime, storeId: $storeId)';
  }

  @override
  bool operator ==(covariant PassOrderModel other) {
    if (identical(this, other)) return true;

    return other.discount == discount &&
        other.totalPrice == totalPrice &&
        other.price == price &&
        other.seviceProviderId == seviceProviderId &&
        other.serviceProviderName == serviceProviderName &&
        other.ordername == ordername &&
        other.orderDescription == orderDescription &&
        other.mixOrSeparateOrGroupOrPrivet == mixOrSeparateOrGroupOrPrivet &&
        other.orderplanTime == orderplanTime &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    return discount.hashCode ^
        totalPrice.hashCode ^
        price.hashCode ^
        seviceProviderId.hashCode ^
        serviceProviderName.hashCode ^
        ordername.hashCode ^
        orderDescription.hashCode ^
        mixOrSeparateOrGroupOrPrivet.hashCode ^
        orderplanTime.hashCode ^
        storeId.hashCode;
  }
}
