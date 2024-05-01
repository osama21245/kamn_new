// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class CoachPricesModel {
  List<dynamic> prices;
  List<dynamic> planDescriptions;
  List<dynamic> planName;
  List<dynamic> discount;
  List<dynamic> points;
  List<dynamic> isGroup;
  List<dynamic> reservisionTimes;
  CoachPricesModel({
    required this.prices,
    required this.planDescriptions,
    required this.planName,
    required this.discount,
    required this.points,
    required this.isGroup,
    required this.reservisionTimes,
  });

  CoachPricesModel copyWith({
    List<dynamic>? prices,
    List<dynamic>? planDescriptions,
    List<dynamic>? planName,
    List<dynamic>? discount,
    List<dynamic>? points,
    List<dynamic>? isGroup,
    List<dynamic>? reservisionTimes,
  }) {
    return CoachPricesModel(
      prices: prices ?? this.prices,
      planDescriptions: planDescriptions ?? this.planDescriptions,
      planName: planName ?? this.planName,
      discount: discount ?? this.discount,
      points: points ?? this.points,
      isGroup: isGroup ?? this.isGroup,
      reservisionTimes: reservisionTimes ?? this.reservisionTimes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prices': prices,
      'planDescriptions': planDescriptions,
      'planName': planName,
      'discount': discount,
      'points': points,
      'isGroup': isGroup,
      'reservisionTimes': reservisionTimes,
    };
  }

  factory CoachPricesModel.fromMap(Map<String, dynamic> map) {
    return CoachPricesModel(
      prices: List<dynamic>.from((map['prices'] as List<dynamic>)),
      planDescriptions:
          List<dynamic>.from((map['planDescriptions'] as List<dynamic>)),
      planName: List<dynamic>.from((map['planName'] as List<dynamic>)),
      discount: List<dynamic>.from((map['discount'] as List<dynamic>)),
      points: List<dynamic>.from((map['points'] as List<dynamic>)),
      isGroup: List<dynamic>.from((map['isGroup'] as List<dynamic>)),
      reservisionTimes:
          List<dynamic>.from((map['reservisionTimes'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory CoachPricesModel.fromJson(String source) =>
      CoachPricesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CoachPricesModel(prices: $prices, planDescriptions: $planDescriptions, planName: $planName, discount: $discount, points: $points, isGroup: $isGroup, reservisionTimes: $reservisionTimes)';
  }

  @override
  bool operator ==(covariant CoachPricesModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.prices, prices) &&
        listEquals(other.planDescriptions, planDescriptions) &&
        listEquals(other.planName, planName) &&
        listEquals(other.discount, discount) &&
        listEquals(other.points, points) &&
        listEquals(other.isGroup, isGroup) &&
        listEquals(other.reservisionTimes, reservisionTimes);
  }

  @override
  int get hashCode {
    return prices.hashCode ^
        planDescriptions.hashCode ^
        planName.hashCode ^
        discount.hashCode ^
        points.hashCode ^
        isGroup.hashCode ^
        reservisionTimes.hashCode;
  }
}
