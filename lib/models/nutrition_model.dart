// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class NutritionModel {
  final String id;
  final String name;
  final String userId;
  String image;
  final String specialization;
  final int discount;
  final List<dynamic> gallery;
  final double long;
  final double lat;
  final double rating;
  final String about;
  final String city;
  final String region;
  final String faceBook;
  final String instgram;
  final String whatsApp;
  final String dynamicLink;
  NutritionModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.image,
    required this.specialization,
    required this.discount,
    required this.gallery,
    required this.long,
    required this.lat,
    required this.rating,
    required this.about,
    required this.city,
    required this.region,
    required this.faceBook,
    required this.instgram,
    required this.whatsApp,
    required this.dynamicLink,
  });

  NutritionModel copyWith({
    String? id,
    String? name,
    String? userId,
    String? image,
    String? specialization,
    int? discount,
    List<dynamic>? gallery,
    double? long,
    double? lat,
    double? rating,
    String? about,
    String? city,
    String? region,
    String? faceBook,
    String? instgram,
    String? whatsApp,
    String? dynamicLink,
  }) {
    return NutritionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      image: image ?? this.image,
      specialization: specialization ?? this.specialization,
      discount: discount ?? this.discount,
      gallery: gallery ?? this.gallery,
      long: long ?? this.long,
      lat: lat ?? this.lat,
      rating: rating ?? this.rating,
      about: about ?? this.about,
      city: city ?? this.city,
      region: region ?? this.region,
      faceBook: faceBook ?? this.faceBook,
      instgram: instgram ?? this.instgram,
      whatsApp: whatsApp ?? this.whatsApp,
      dynamicLink: dynamicLink ?? this.dynamicLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'image': image,
      'specialization': specialization,
      'discount': discount,
      'gallery': gallery,
      'long': long,
      'lat': lat,
      'rating': rating,
      'about': about,
      'city': city,
      'region': region,
      'faceBook': faceBook,
      'instgram': instgram,
      'whatsApp': whatsApp,
      'dynamicLink': dynamicLink,
    };
  }

  factory NutritionModel.fromMap(Map<String, dynamic> map) {
    return NutritionModel(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['userId'] as String,
      image: map['image'] as String,
      specialization: map['specialization'] as String,
      discount: map['discount'] as int,
      gallery: List<dynamic>.from((map['gallery'] as List<dynamic>)),
      long: map['long'] as double,
      lat: map['lat'] as double,
      rating: map['rating'] as double,
      about: map['about'] as String,
      city: map['city'] as String,
      region: map['region'] as String,
      faceBook: map['faceBook'] as String,
      instgram: map['instgram'] as String,
      whatsApp: map['whatsApp'] as String,
      dynamicLink: map['dynamicLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NutritionModel.fromJson(String source) =>
      NutritionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NutritionModel(id: $id, name: $name, userId: $userId, image: $image, specialization: $specialization, discount: $discount, gallery: $gallery, long: $long, lat: $lat, rating: $rating, about: $about, city: $city, region: $region, faceBook: $faceBook, instgram: $instgram, whatsApp: $whatsApp, dynamicLink: $dynamicLink)';
  }

  @override
  bool operator ==(covariant NutritionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        other.image == image &&
        other.specialization == specialization &&
        other.discount == discount &&
        listEquals(other.gallery, gallery) &&
        other.long == long &&
        other.lat == lat &&
        other.rating == rating &&
        other.about == about &&
        other.city == city &&
        other.region == region &&
        other.faceBook == faceBook &&
        other.instgram == instgram &&
        other.whatsApp == whatsApp &&
        other.dynamicLink == dynamicLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        image.hashCode ^
        specialization.hashCode ^
        discount.hashCode ^
        gallery.hashCode ^
        long.hashCode ^
        lat.hashCode ^
        rating.hashCode ^
        about.hashCode ^
        city.hashCode ^
        region.hashCode ^
        faceBook.hashCode ^
        instgram.hashCode ^
        whatsApp.hashCode ^
        dynamicLink.hashCode;
  }
}
