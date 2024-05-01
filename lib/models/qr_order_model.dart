// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QrOrderModel {
  final String orderid;
  final String storeId;
  final String offerId;
  final String userId;
  final String offerTitle;
  final String offerDescription;
  final String offerPrice;
  final String offerDiscount;
  final String category;
  final String image;
  final String serviceProviderId;
  final String qrLink;
  final DateTime date;
  QrOrderModel({
    required this.orderid,
    required this.storeId,
    required this.offerId,
    required this.userId,
    required this.offerTitle,
    required this.offerDescription,
    required this.offerPrice,
    required this.offerDiscount,
    required this.category,
    required this.image,
    required this.serviceProviderId,
    required this.qrLink,
    required this.date,
  });

  QrOrderModel copyWith({
    String? orderid,
    String? storeId,
    String? offerId,
    String? userId,
    String? offerTitle,
    String? offerDescription,
    String? offerPrice,
    String? offerDiscount,
    String? category,
    String? image,
    String? serviceProviderId,
    String? qrLink,
    DateTime? date,
  }) {
    return QrOrderModel(
      orderid: orderid ?? this.orderid,
      storeId: storeId ?? this.storeId,
      offerId: offerId ?? this.offerId,
      userId: userId ?? this.userId,
      offerTitle: offerTitle ?? this.offerTitle,
      offerDescription: offerDescription ?? this.offerDescription,
      offerPrice: offerPrice ?? this.offerPrice,
      offerDiscount: offerDiscount ?? this.offerDiscount,
      category: category ?? this.category,
      image: image ?? this.image,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      qrLink: qrLink ?? this.qrLink,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderid': orderid,
      'storeId': storeId,
      'offerId': offerId,
      'userId': userId,
      'offerTitle': offerTitle,
      'offerDescription': offerDescription,
      'offerPrice': offerPrice,
      'offerDiscount': offerDiscount,
      'category': category,
      'image': image,
      'serviceProviderId': serviceProviderId,
      'qrLink': qrLink,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory QrOrderModel.fromMap(Map<String, dynamic> map) {
    return QrOrderModel(
      orderid: map['orderid'] as String,
      storeId: map['storeId'] as String,
      offerId: map['offerId'] as String,
      userId: map['userId'] as String,
      offerTitle: map['offerTitle'] as String,
      offerDescription: map['offerDescription'] as String,
      offerPrice: map['offerPrice'] as String,
      offerDiscount: map['offerDiscount'] as String,
      category: map['category'] as String,
      image: map['image'] as String,
      serviceProviderId: map['serviceProviderId'] as String,
      qrLink: map['qrLink'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory QrOrderModel.fromJson(String source) =>
      QrOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QrOrderModel(orderid: $orderid, storeId: $storeId, offerId: $offerId, userId: $userId, offerTitle: $offerTitle, offerDescription: $offerDescription, offerPrice: $offerPrice, offerDiscount: $offerDiscount, category: $category, image: $image, serviceProviderId: $serviceProviderId, qrLink: $qrLink, date: $date)';
  }

  @override
  bool operator ==(covariant QrOrderModel other) {
    if (identical(this, other)) return true;

    return other.orderid == orderid &&
        other.storeId == storeId &&
        other.offerId == offerId &&
        other.userId == userId &&
        other.offerTitle == offerTitle &&
        other.offerDescription == offerDescription &&
        other.offerPrice == offerPrice &&
        other.offerDiscount == offerDiscount &&
        other.category == category &&
        other.image == image &&
        other.serviceProviderId == serviceProviderId &&
        other.qrLink == qrLink &&
        other.date == date;
  }

  @override
  int get hashCode {
    return orderid.hashCode ^
        storeId.hashCode ^
        offerId.hashCode ^
        userId.hashCode ^
        offerTitle.hashCode ^
        offerDescription.hashCode ^
        offerPrice.hashCode ^
        offerDiscount.hashCode ^
        category.hashCode ^
        image.hashCode ^
        serviceProviderId.hashCode ^
        qrLink.hashCode ^
        date.hashCode;
  }
}
