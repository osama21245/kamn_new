// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MedicalModel {
  final String id;
  final String userId;
  final String name;
  final double rating;
  String image;
  final String education;
  final int price;
  final double lat;
  final double long;
  final String specialization;
  final String experience;
  final String region;
  final String city;
  final List<dynamic> gallery;
  final List<dynamic> from;
  final List<dynamic> to;
  final String benefits;
  final String faceBook;
  final String instgram;
  final String dynamicLink;
  final String whatAppNum;
  final int discount;
  MedicalModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.rating,
    required this.image,
    required this.education,
    required this.price,
    required this.lat,
    required this.long,
    required this.specialization,
    required this.experience,
    required this.region,
    required this.city,
    required this.gallery,
    required this.from,
    required this.to,
    required this.benefits,
    required this.faceBook,
    required this.instgram,
    required this.dynamicLink,
    required this.whatAppNum,
    required this.discount,
  });

  MedicalModel copyWith({
    String? id,
    String? userId,
    String? name,
    double? rating,
    String? image,
    String? education,
    int? price,
    double? lat,
    double? long,
    String? specialization,
    String? experience,
    String? region,
    String? city,
    List<dynamic>? gallery,
    List<dynamic>? from,
    List<dynamic>? to,
    String? benefits,
    String? faceBook,
    String? instgram,
    String? dynamicLink,
    String? whatAppNum,
    int? discount,
  }) {
    return MedicalModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      education: education ?? this.education,
      price: price ?? this.price,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      specialization: specialization ?? this.specialization,
      experience: experience ?? this.experience,
      region: region ?? this.region,
      city: city ?? this.city,
      gallery: gallery ?? this.gallery,
      from: from ?? this.from,
      to: to ?? this.to,
      benefits: benefits ?? this.benefits,
      faceBook: faceBook ?? this.faceBook,
      instgram: instgram ?? this.instgram,
      dynamicLink: dynamicLink ?? this.dynamicLink,
      whatAppNum: whatAppNum ?? this.whatAppNum,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'name': name,
      'rating': rating,
      'image': image,
      'education': education,
      'price': price,
      'lat': lat,
      'long': long,
      'specialization': specialization,
      'experience': experience,
      'region': region,
      'city': city,
      'gallery': gallery,
      'from': from,
      'to': to,
      'benefits': benefits,
      'faceBook': faceBook,
      'instgram': instgram,
      'dynamicLink': dynamicLink,
      'whatAppNum': whatAppNum,
      'discount': discount,
    };
  }

  factory MedicalModel.fromMap(Map<String, dynamic> map) {
    return MedicalModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      name: map['name'] as String,
      rating: map['rating'] as double,
      image: map['image'] as String,
      education: map['education'] as String,
      price: map['price'] as int,
      lat: map['lat'] as double,
      long: map['long'] as double,
      specialization: map['specialization'] as String,
      experience: map['experience'] as String,
      region: map['region'] as String,
      city: map['city'] as String,
      gallery: List<dynamic>.from((map['gallery'] as List<dynamic>)),
      from: List<dynamic>.from((map['from'] as List<dynamic>)),
      to: List<dynamic>.from((map['to'] as List<dynamic>)),
      benefits: map['benefits'] as String,
      faceBook: map['faceBook'] as String,
      instgram: map['instgram'] as String,
      dynamicLink: map['dynamicLink'] as String,
      whatAppNum: map['whatAppNum'] as String,
      discount: map['discount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalModel.fromJson(String source) =>
      MedicalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MedicalModel(id: $id, userId: $userId, name: $name, rating: $rating, image: $image, education: $education, price: $price, lat: $lat, long: $long, specialization: $specialization, experience: $experience, region: $region, city: $city, gallery: $gallery, from: $from, to: $to, benefits: $benefits, faceBook: $faceBook, instgram: $instgram, dynamicLink: $dynamicLink, whatAppNum: $whatAppNum, discount: $discount)';
  }

  @override
  bool operator ==(covariant MedicalModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.name == name &&
        other.rating == rating &&
        other.image == image &&
        other.education == education &&
        other.price == price &&
        other.lat == lat &&
        other.long == long &&
        other.specialization == specialization &&
        other.experience == experience &&
        other.region == region &&
        other.city == city &&
        listEquals(other.gallery, gallery) &&
        listEquals(other.from, from) &&
        listEquals(other.to, to) &&
        other.benefits == benefits &&
        other.faceBook == faceBook &&
        other.instgram == instgram &&
        other.dynamicLink == dynamicLink &&
        other.whatAppNum == whatAppNum &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        rating.hashCode ^
        image.hashCode ^
        education.hashCode ^
        price.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        specialization.hashCode ^
        experience.hashCode ^
        region.hashCode ^
        city.hashCode ^
        gallery.hashCode ^
        from.hashCode ^
        to.hashCode ^
        benefits.hashCode ^
        faceBook.hashCode ^
        instgram.hashCode ^
        dynamicLink.hashCode ^
        whatAppNum.hashCode ^
        discount.hashCode;
  }
}
