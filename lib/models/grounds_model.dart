// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GroundModel {
  final String id;
  final String name;
  final String address;
  String image;
  final String groundOwnerId;
  final String city;
  final String region;
  final List<dynamic> gallery;
  final int price;
  final int rating;
  final String groundnumber;
  final int groundPlayersNum;
  final String futuers;
  final double long;
  final double lat;
  GroundModel({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.groundOwnerId,
    required this.city,
    required this.region,
    required this.gallery,
    required this.price,
    required this.rating,
    required this.groundnumber,
    required this.groundPlayersNum,
    required this.futuers,
    required this.long,
    required this.lat,
  });

  GroundModel copyWith({
    String? id,
    String? name,
    String? address,
    String? image,
    String? groundOwnerId,
    String? city,
    String? region,
    List<dynamic>? gallery,
    int? price,
    int? rating,
    String? groundnumber,
    int? groundPlayersNum,
    String? futuers,
    double? long,
    double? lat,
  }) {
    return GroundModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      image: image ?? this.image,
      groundOwnerId: groundOwnerId ?? this.groundOwnerId,
      city: city ?? this.city,
      region: region ?? this.region,
      gallery: gallery ?? this.gallery,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      groundnumber: groundnumber ?? this.groundnumber,
      groundPlayersNum: groundPlayersNum ?? this.groundPlayersNum,
      futuers: futuers ?? this.futuers,
      long: long ?? this.long,
      lat: lat ?? this.lat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'image': image,
      'groundOwnerId': groundOwnerId,
      'city': city,
      'region': region,
      'gallery': gallery,
      'price': price,
      'rating': rating,
      'groundnumber': groundnumber,
      'groundPlayersNum': groundPlayersNum,
      'futuers': futuers,
      'long': long,
      'lat': lat,
    };
  }

  factory GroundModel.fromMap(Map<String, dynamic> map) {
    return GroundModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      image: map['image'] as String,
      groundOwnerId: map['groundOwnerId'] as String,
      city: map['city'] as String,
      region: map['region'] as String,
      gallery: List<dynamic>.from((map['gallery'] as List<dynamic>)),
      price: map['price'] as int,
      rating: map['rating'] as int,
      groundnumber: map['groundnumber'] as String,
      groundPlayersNum: map['groundPlayersNum'] as int,
      futuers: map['futuers'] as String,
      long: map['long'] as double,
      lat: map['lat'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroundModel.fromJson(String source) =>
      GroundModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroundModel(id: $id, name: $name, address: $address, image: $image, groundOwnerId: $groundOwnerId, city: $city, region: $region, gallery: $gallery, price: $price, rating: $rating, groundnumber: $groundnumber, groundPlayersNum: $groundPlayersNum, futuers: $futuers, long: $long, lat: $lat)';
  }

  @override
  bool operator ==(covariant GroundModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.image == image &&
        other.groundOwnerId == groundOwnerId &&
        other.city == city &&
        other.region == region &&
        listEquals(other.gallery, gallery) &&
        other.price == price &&
        other.rating == rating &&
        other.groundnumber == groundnumber &&
        other.groundPlayersNum == groundPlayersNum &&
        other.futuers == futuers &&
        other.long == long &&
        other.lat == lat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        image.hashCode ^
        groundOwnerId.hashCode ^
        city.hashCode ^
        region.hashCode ^
        gallery.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        groundnumber.hashCode ^
        groundPlayersNum.hashCode ^
        futuers.hashCode ^
        long.hashCode ^
        lat.hashCode;
  }
}
