// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class PricesModel {
  List<dynamic> prices;
  List<dynamic> planDescriptions;
  List<dynamic> planName;
  List<dynamic> discount;
  List<dynamic> points;

  PricesModel({
    required this.prices,
    required this.planDescriptions,
    required this.planName,
    required this.discount,
    required this.points,
  });

  PricesModel copyWith({
    List<dynamic>? prices,
    List<dynamic>? planDescriptions,
    List<dynamic>? planName,
    List<dynamic>? discount,
    List<dynamic>? points,
  }) {
    return PricesModel(
      prices: prices ?? this.prices,
      planDescriptions: planDescriptions ?? this.planDescriptions,
      planName: planName ?? this.planName,
      discount: discount ?? this.discount,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prices': prices,
      'planDescriptions': planDescriptions,
      'planName': planName,
      'discount': discount,
      'points': points,
    };
  }

  factory PricesModel.fromMap(Map<String, dynamic> map) {
    return PricesModel(
      prices: List<dynamic>.from((map['prices'] as List<dynamic>)),
      planDescriptions:
          List<dynamic>.from((map['planDescriptions'] as List<dynamic>)),
      planName: List<dynamic>.from((map['planName'] as List<dynamic>)),
      discount: List<dynamic>.from((map['discount'] as List<dynamic>)),
      points: List<dynamic>.from((map['points'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory PricesModel.fromJson(String source) =>
      PricesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PricesModel(prices: $prices, planDescriptions: $planDescriptions, planName: $planName, discount: $discount, points: $points)';
  }

  @override
  bool operator ==(covariant PricesModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.prices, prices) &&
        listEquals(other.planDescriptions, planDescriptions) &&
        listEquals(other.planName, planName) &&
        listEquals(other.discount, discount) &&
        listEquals(other.points, points);
  }

  @override
  int get hashCode {
    return prices.hashCode ^
        planDescriptions.hashCode ^
        planName.hashCode ^
        discount.hashCode ^
        points.hashCode;
  }
}
