// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class GymPricesModel {
  List<dynamic> prices;
  List<dynamic> planDescriptions;
  List<dynamic> planName;
  List<dynamic> discount;
  List<dynamic> points;
  List<dynamic> ismix;
  List<dynamic> planTime;
  GymPricesModel({
    required this.prices,
    required this.planDescriptions,
    required this.planName,
    required this.discount,
    required this.points,
    required this.ismix,
    required this.planTime,
  });

  GymPricesModel copyWith({
    List<dynamic>? prices,
    List<dynamic>? planDescriptions,
    List<dynamic>? planName,
    List<dynamic>? discount,
    List<dynamic>? points,
    List<dynamic>? ismix,
    List<dynamic>? planTime,
  }) {
    return GymPricesModel(
      prices: prices ?? this.prices,
      planDescriptions: planDescriptions ?? this.planDescriptions,
      planName: planName ?? this.planName,
      discount: discount ?? this.discount,
      points: points ?? this.points,
      ismix: ismix ?? this.ismix,
      planTime: planTime ?? this.planTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prices': prices,
      'planDescriptions': planDescriptions,
      'planName': planName,
      'discount': discount,
      'points': points,
      'ismix': ismix,
      'planTime': planTime,
    };
  }

  factory GymPricesModel.fromMap(Map<String, dynamic> map) {
    return GymPricesModel(
      prices: List<dynamic>.from((map['prices'] as List<dynamic>)),
      planDescriptions:
          List<dynamic>.from((map['planDescriptions'] as List<dynamic>)),
      planName: List<dynamic>.from((map['planName'] as List<dynamic>)),
      discount: List<dynamic>.from((map['discount'] as List<dynamic>)),
      points: List<dynamic>.from((map['points'] as List<dynamic>)),
      ismix: List<dynamic>.from((map['ismix'] as List<dynamic>)),
      planTime: List<dynamic>.from((map['planTime'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory GymPricesModel.fromJson(String source) =>
      GymPricesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GymPricesModel(prices: $prices, planDescriptions: $planDescriptions, planName: $planName, discount: $discount, points: $points, ismix: $ismix, planTime: $planTime)';
  }

  @override
  bool operator ==(covariant GymPricesModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.prices, prices) &&
        listEquals(other.planDescriptions, planDescriptions) &&
        listEquals(other.planName, planName) &&
        listEquals(other.discount, discount) &&
        listEquals(other.points, points) &&
        listEquals(other.ismix, ismix) &&
        listEquals(other.planTime, planTime);
  }

  @override
  int get hashCode {
    return prices.hashCode ^
        planDescriptions.hashCode ^
        planName.hashCode ^
        discount.hashCode ^
        points.hashCode ^
        ismix.hashCode ^
        planTime.hashCode;
  }
}
