// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GymLocationsModel {
  final String id;
  final String name;
  final String userId;
  final String mainGymId;
  final String image;
  final List<dynamic> gallery;
  final List<dynamic> offersSpecial;
  final List<dynamic> offerspoints;
  final List<dynamic> offersprices;
  final List<dynamic> offersplanDescriptions;
  final List<dynamic> offersPlanName;
  final List<dynamic> offersdiscount;
  final List<dynamic> offersisMix;
  final List<dynamic> offersplanTime;
  final List<dynamic> fitnessisSpecial;
  final List<dynamic> fitnesspoints;
  final List<dynamic> fitnessprices;
  final List<dynamic> fitnessplanDescriptions;
  final List<dynamic> fitnessplanName;
  final List<dynamic> fitnessdiscount;
  final List<dynamic> fitnessisMix;
  final List<dynamic> fitnessplanTime;
  final List<dynamic> weightLiftisSpecial;
  final List<dynamic> weightLiftpoints;
  final List<dynamic> weightLiftprices;
  final List<dynamic> weightLiftplanDescriptions;
  final List<dynamic> weightLiftplanName;
  final List<dynamic> weightLiftdiscount;
  final List<dynamic> weightLiftisMix;
  final List<dynamic> weightLiftplanTime;
  final List<dynamic> servicesisSpecial;
  final List<dynamic> servicespoints;
  final List<dynamic> servicesprices;
  final List<dynamic> servicesplanDescriptions;
  final List<dynamic> servicesplanName;
  final List<dynamic> servicesdiscount;
  final List<dynamic> servicesdisMix;
  final List<dynamic> servicesplanTime;
  final String facebook;
  final String instgram;
  final String dynamicLink;
  final String whatsAppNum;
  final String region;
  final String city;
  final double rating;
  final bool ismix;

  final String address;
  final double long;
  final double lat;
  GymLocationsModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.mainGymId,
    required this.image,
    required this.gallery,
    required this.offersSpecial,
    required this.offerspoints,
    required this.offersprices,
    required this.offersplanDescriptions,
    required this.offersPlanName,
    required this.offersdiscount,
    required this.offersisMix,
    required this.offersplanTime,
    required this.fitnessisSpecial,
    required this.fitnesspoints,
    required this.fitnessprices,
    required this.fitnessplanDescriptions,
    required this.fitnessplanName,
    required this.fitnessdiscount,
    required this.fitnessisMix,
    required this.fitnessplanTime,
    required this.weightLiftisSpecial,
    required this.weightLiftpoints,
    required this.weightLiftprices,
    required this.weightLiftplanDescriptions,
    required this.weightLiftplanName,
    required this.weightLiftdiscount,
    required this.weightLiftisMix,
    required this.weightLiftplanTime,
    required this.servicesisSpecial,
    required this.servicespoints,
    required this.servicesprices,
    required this.servicesplanDescriptions,
    required this.servicesplanName,
    required this.servicesdiscount,
    required this.servicesdisMix,
    required this.servicesplanTime,
    required this.facebook,
    required this.instgram,
    required this.dynamicLink,
    required this.whatsAppNum,
    required this.region,
    required this.city,
    required this.rating,
    required this.ismix,
    required this.address,
    required this.long,
    required this.lat,
  });

  GymLocationsModel copyWith({
    String? id,
    String? name,
    String? userId,
    String? mainGymId,
    String? image,
    List<dynamic>? gallery,
    List<dynamic>? offersSpecial,
    List<dynamic>? offerspoints,
    List<dynamic>? offersprices,
    List<dynamic>? offersplanDescriptions,
    List<dynamic>? offersPlanName,
    List<dynamic>? offersdiscount,
    List<dynamic>? offersisMix,
    List<dynamic>? offersplanTime,
    List<dynamic>? fitnessisSpecial,
    List<dynamic>? fitnesspoints,
    List<dynamic>? fitnessprices,
    List<dynamic>? fitnessplanDescriptions,
    List<dynamic>? fitnessplanName,
    List<dynamic>? fitnessdiscount,
    List<dynamic>? fitnessisMix,
    List<dynamic>? fitnessplanTime,
    List<dynamic>? weightLiftisSpecial,
    List<dynamic>? weightLiftpoints,
    List<dynamic>? weightLiftprices,
    List<dynamic>? weightLiftplanDescriptions,
    List<dynamic>? weightLiftplanName,
    List<dynamic>? weightLiftdiscount,
    List<dynamic>? weightLiftisMix,
    List<dynamic>? weightLiftplanTime,
    List<dynamic>? servicesisSpecial,
    List<dynamic>? servicespoints,
    List<dynamic>? servicesprices,
    List<dynamic>? servicesplanDescriptions,
    List<dynamic>? servicesplanName,
    List<dynamic>? servicesdiscount,
    List<dynamic>? servicesdisMix,
    List<dynamic>? servicesplanTime,
    String? facebook,
    String? instgram,
    String? dynamicLink,
    String? whatsAppNum,
    String? region,
    String? city,
    double? rating,
    bool? ismix,
    String? address,
    double? long,
    double? lat,
  }) {
    return GymLocationsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      mainGymId: mainGymId ?? this.mainGymId,
      image: image ?? this.image,
      gallery: gallery ?? this.gallery,
      offersSpecial: offersSpecial ?? this.offersSpecial,
      offerspoints: offerspoints ?? this.offerspoints,
      offersprices: offersprices ?? this.offersprices,
      offersplanDescriptions:
          offersplanDescriptions ?? this.offersplanDescriptions,
      offersPlanName: offersPlanName ?? this.offersPlanName,
      offersdiscount: offersdiscount ?? this.offersdiscount,
      offersisMix: offersisMix ?? this.offersisMix,
      offersplanTime: offersplanTime ?? this.offersplanTime,
      fitnessisSpecial: fitnessisSpecial ?? this.fitnessisSpecial,
      fitnesspoints: fitnesspoints ?? this.fitnesspoints,
      fitnessprices: fitnessprices ?? this.fitnessprices,
      fitnessplanDescriptions:
          fitnessplanDescriptions ?? this.fitnessplanDescriptions,
      fitnessplanName: fitnessplanName ?? this.fitnessplanName,
      fitnessdiscount: fitnessdiscount ?? this.fitnessdiscount,
      fitnessisMix: fitnessisMix ?? this.fitnessisMix,
      fitnessplanTime: fitnessplanTime ?? this.fitnessplanTime,
      weightLiftisSpecial: weightLiftisSpecial ?? this.weightLiftisSpecial,
      weightLiftpoints: weightLiftpoints ?? this.weightLiftpoints,
      weightLiftprices: weightLiftprices ?? this.weightLiftprices,
      weightLiftplanDescriptions:
          weightLiftplanDescriptions ?? this.weightLiftplanDescriptions,
      weightLiftplanName: weightLiftplanName ?? this.weightLiftplanName,
      weightLiftdiscount: weightLiftdiscount ?? this.weightLiftdiscount,
      weightLiftisMix: weightLiftisMix ?? this.weightLiftisMix,
      weightLiftplanTime: weightLiftplanTime ?? this.weightLiftplanTime,
      servicesisSpecial: servicesisSpecial ?? this.servicesisSpecial,
      servicespoints: servicespoints ?? this.servicespoints,
      servicesprices: servicesprices ?? this.servicesprices,
      servicesplanDescriptions:
          servicesplanDescriptions ?? this.servicesplanDescriptions,
      servicesplanName: servicesplanName ?? this.servicesplanName,
      servicesdiscount: servicesdiscount ?? this.servicesdiscount,
      servicesdisMix: servicesdisMix ?? this.servicesdisMix,
      servicesplanTime: servicesplanTime ?? this.servicesplanTime,
      facebook: facebook ?? this.facebook,
      instgram: instgram ?? this.instgram,
      dynamicLink: dynamicLink ?? this.dynamicLink,
      whatsAppNum: whatsAppNum ?? this.whatsAppNum,
      region: region ?? this.region,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      ismix: ismix ?? this.ismix,
      address: address ?? this.address,
      long: long ?? this.long,
      lat: lat ?? this.lat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'mainGymId': mainGymId,
      'image': image,
      'gallery': gallery,
      'offersSpecial': offersSpecial,
      'offerspoints': offerspoints,
      'offersprices': offersprices,
      'offersplanDescriptions': offersplanDescriptions,
      'offersPlanName': offersPlanName,
      'offersdiscount': offersdiscount,
      'offersisMix': offersisMix,
      'offersplanTime': offersplanTime,
      'fitnessisSpecial': fitnessisSpecial,
      'fitnesspoints': fitnesspoints,
      'fitnessprices': fitnessprices,
      'fitnessplanDescriptions': fitnessplanDescriptions,
      'fitnessplanName': fitnessplanName,
      'fitnessdiscount': fitnessdiscount,
      'fitnessisMix': fitnessisMix,
      'fitnessplanTime': fitnessplanTime,
      'weightLiftisSpecial': weightLiftisSpecial,
      'weightLiftpoints': weightLiftpoints,
      'weightLiftprices': weightLiftprices,
      'weightLiftplanDescriptions': weightLiftplanDescriptions,
      'weightLiftplanName': weightLiftplanName,
      'weightLiftdiscount': weightLiftdiscount,
      'weightLiftisMix': weightLiftisMix,
      'weightLiftplanTime': weightLiftplanTime,
      'servicesisSpecial': servicesisSpecial,
      'servicespoints': servicespoints,
      'servicesprices': servicesprices,
      'servicesplanDescriptions': servicesplanDescriptions,
      'servicesplanName': servicesplanName,
      'servicesdiscount': servicesdiscount,
      'servicesdisMix': servicesdisMix,
      'servicesplanTime': servicesplanTime,
      'facebook': facebook,
      'instgram': instgram,
      'dynamicLink': dynamicLink,
      'whatsAppNum': whatsAppNum,
      'region': region,
      'city': city,
      'rating': rating,
      'ismix': ismix,
      'address': address,
      'long': long,
      'lat': lat,
    };
  }

  factory GymLocationsModel.fromMap(Map<String, dynamic> map) {
    return GymLocationsModel(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['userId'] as String,
      mainGymId: map['mainGymId'] as String,
      image: map['image'] as String,
      gallery: List<dynamic>.from((map['gallery'] as List<dynamic>)),
      offersSpecial:
          List<dynamic>.from((map['offersSpecial'] as List<dynamic>)),
      offerspoints: List<dynamic>.from((map['offerspoints'] as List<dynamic>)),
      offersprices: List<dynamic>.from((map['offersprices'] as List<dynamic>)),
      offersplanDescriptions:
          List<dynamic>.from((map['offersplanDescriptions'] as List<dynamic>)),
      offersPlanName:
          List<dynamic>.from((map['offersPlanName'] as List<dynamic>)),
      offersdiscount:
          List<dynamic>.from((map['offersdiscount'] as List<dynamic>)),
      offersisMix: List<dynamic>.from((map['offersisMix'] as List<dynamic>)),
      offersplanTime:
          List<dynamic>.from((map['offersplanTime'] as List<dynamic>)),
      fitnessisSpecial:
          List<dynamic>.from((map['fitnessisSpecial'] as List<dynamic>)),
      fitnesspoints:
          List<dynamic>.from((map['fitnesspoints'] as List<dynamic>)),
      fitnessprices:
          List<dynamic>.from((map['fitnessprices'] as List<dynamic>)),
      fitnessplanDescriptions:
          List<dynamic>.from((map['fitnessplanDescriptions'] as List<dynamic>)),
      fitnessplanName:
          List<dynamic>.from((map['fitnessplanName'] as List<dynamic>)),
      fitnessdiscount:
          List<dynamic>.from((map['fitnessdiscount'] as List<dynamic>)),
      fitnessisMix: List<dynamic>.from((map['fitnessisMix'] as List<dynamic>)),
      fitnessplanTime:
          List<dynamic>.from((map['fitnessplanTime'] as List<dynamic>)),
      weightLiftisSpecial:
          List<dynamic>.from((map['weightLiftisSpecial'] as List<dynamic>)),
      weightLiftpoints:
          List<dynamic>.from((map['weightLiftpoints'] as List<dynamic>)),
      weightLiftprices:
          List<dynamic>.from((map['weightLiftprices'] as List<dynamic>)),
      weightLiftplanDescriptions: List<dynamic>.from(
          (map['weightLiftplanDescriptions'] as List<dynamic>)),
      weightLiftplanName:
          List<dynamic>.from((map['weightLiftplanName'] as List<dynamic>)),
      weightLiftdiscount:
          List<dynamic>.from((map['weightLiftdiscount'] as List<dynamic>)),
      weightLiftisMix:
          List<dynamic>.from((map['weightLiftisMix'] as List<dynamic>)),
      weightLiftplanTime:
          List<dynamic>.from((map['weightLiftplanTime'] as List<dynamic>)),
      servicesisSpecial:
          List<dynamic>.from((map['servicesisSpecial'] as List<dynamic>)),
      servicespoints:
          List<dynamic>.from((map['servicespoints'] as List<dynamic>)),
      servicesprices:
          List<dynamic>.from((map['servicesprices'] as List<dynamic>)),
      servicesplanDescriptions: List<dynamic>.from(
          (map['servicesplanDescriptions'] as List<dynamic>)),
      servicesplanName:
          List<dynamic>.from((map['servicesplanName'] as List<dynamic>)),
      servicesdiscount:
          List<dynamic>.from((map['servicesdiscount'] as List<dynamic>)),
      servicesdisMix:
          List<dynamic>.from((map['servicesdisMix'] as List<dynamic>)),
      servicesplanTime:
          List<dynamic>.from((map['servicesplanTime'] as List<dynamic>)),
      facebook: map['facebook'] as String,
      instgram: map['instgram'] as String,
      dynamicLink: map['dynamicLink'] as String,
      whatsAppNum: map['whatsAppNum'] as String,
      region: map['region'] as String,
      city: map['city'] as String,
      rating: map['rating'] as double,
      ismix: map['ismix'] as bool,
      address: map['address'] as String,
      long: map['long'] as double,
      lat: map['lat'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory GymLocationsModel.fromJson(String source) =>
      GymLocationsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GymLocationsModel(id: $id, name: $name, userId: $userId, mainGymId: $mainGymId, image: $image, gallery: $gallery, offersSpecial: $offersSpecial, offerspoints: $offerspoints, offersprices: $offersprices, offersplanDescriptions: $offersplanDescriptions, offersPlanName: $offersPlanName, offersdiscount: $offersdiscount, offersisMix: $offersisMix, offersplanTime: $offersplanTime, fitnessisSpecial: $fitnessisSpecial, fitnesspoints: $fitnesspoints, fitnessprices: $fitnessprices, fitnessplanDescriptions: $fitnessplanDescriptions, fitnessplanName: $fitnessplanName, fitnessdiscount: $fitnessdiscount, fitnessisMix: $fitnessisMix, fitnessplanTime: $fitnessplanTime, weightLiftisSpecial: $weightLiftisSpecial, weightLiftpoints: $weightLiftpoints, weightLiftprices: $weightLiftprices, weightLiftplanDescriptions: $weightLiftplanDescriptions, weightLiftplanName: $weightLiftplanName, weightLiftdiscount: $weightLiftdiscount, weightLiftisMix: $weightLiftisMix, weightLiftplanTime: $weightLiftplanTime, servicesisSpecial: $servicesisSpecial, servicespoints: $servicespoints, servicesprices: $servicesprices, servicesplanDescriptions: $servicesplanDescriptions, servicesplanName: $servicesplanName, servicesdiscount: $servicesdiscount, servicesdisMix: $servicesdisMix, servicesplanTime: $servicesplanTime, facebook: $facebook, instgram: $instgram, dynamicLink: $dynamicLink, whatsAppNum: $whatsAppNum, region: $region, city: $city, rating: $rating, ismix: $ismix, address: $address, long: $long, lat: $lat)';
  }

  @override
  bool operator ==(covariant GymLocationsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        other.mainGymId == mainGymId &&
        other.image == image &&
        listEquals(other.gallery, gallery) &&
        listEquals(other.offersSpecial, offersSpecial) &&
        listEquals(other.offerspoints, offerspoints) &&
        listEquals(other.offersprices, offersprices) &&
        listEquals(other.offersplanDescriptions, offersplanDescriptions) &&
        listEquals(other.offersPlanName, offersPlanName) &&
        listEquals(other.offersdiscount, offersdiscount) &&
        listEquals(other.offersisMix, offersisMix) &&
        listEquals(other.offersplanTime, offersplanTime) &&
        listEquals(other.fitnessisSpecial, fitnessisSpecial) &&
        listEquals(other.fitnesspoints, fitnesspoints) &&
        listEquals(other.fitnessprices, fitnessprices) &&
        listEquals(other.fitnessplanDescriptions, fitnessplanDescriptions) &&
        listEquals(other.fitnessplanName, fitnessplanName) &&
        listEquals(other.fitnessdiscount, fitnessdiscount) &&
        listEquals(other.fitnessisMix, fitnessisMix) &&
        listEquals(other.fitnessplanTime, fitnessplanTime) &&
        listEquals(other.weightLiftisSpecial, weightLiftisSpecial) &&
        listEquals(other.weightLiftpoints, weightLiftpoints) &&
        listEquals(other.weightLiftprices, weightLiftprices) &&
        listEquals(
            other.weightLiftplanDescriptions, weightLiftplanDescriptions) &&
        listEquals(other.weightLiftplanName, weightLiftplanName) &&
        listEquals(other.weightLiftdiscount, weightLiftdiscount) &&
        listEquals(other.weightLiftisMix, weightLiftisMix) &&
        listEquals(other.weightLiftplanTime, weightLiftplanTime) &&
        listEquals(other.servicesisSpecial, servicesisSpecial) &&
        listEquals(other.servicespoints, servicespoints) &&
        listEquals(other.servicesprices, servicesprices) &&
        listEquals(other.servicesplanDescriptions, servicesplanDescriptions) &&
        listEquals(other.servicesplanName, servicesplanName) &&
        listEquals(other.servicesdiscount, servicesdiscount) &&
        listEquals(other.servicesdisMix, servicesdisMix) &&
        listEquals(other.servicesplanTime, servicesplanTime) &&
        other.facebook == facebook &&
        other.instgram == instgram &&
        other.dynamicLink == dynamicLink &&
        other.whatsAppNum == whatsAppNum &&
        other.region == region &&
        other.city == city &&
        other.rating == rating &&
        other.ismix == ismix &&
        other.address == address &&
        other.long == long &&
        other.lat == lat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        mainGymId.hashCode ^
        image.hashCode ^
        gallery.hashCode ^
        offersSpecial.hashCode ^
        offerspoints.hashCode ^
        offersprices.hashCode ^
        offersplanDescriptions.hashCode ^
        offersPlanName.hashCode ^
        offersdiscount.hashCode ^
        offersisMix.hashCode ^
        offersplanTime.hashCode ^
        fitnessisSpecial.hashCode ^
        fitnesspoints.hashCode ^
        fitnessprices.hashCode ^
        fitnessplanDescriptions.hashCode ^
        fitnessplanName.hashCode ^
        fitnessdiscount.hashCode ^
        fitnessisMix.hashCode ^
        fitnessplanTime.hashCode ^
        weightLiftisSpecial.hashCode ^
        weightLiftpoints.hashCode ^
        weightLiftprices.hashCode ^
        weightLiftplanDescriptions.hashCode ^
        weightLiftplanName.hashCode ^
        weightLiftdiscount.hashCode ^
        weightLiftisMix.hashCode ^
        weightLiftplanTime.hashCode ^
        servicesisSpecial.hashCode ^
        servicespoints.hashCode ^
        servicesprices.hashCode ^
        servicesplanDescriptions.hashCode ^
        servicesplanName.hashCode ^
        servicesdiscount.hashCode ^
        servicesdisMix.hashCode ^
        servicesplanTime.hashCode ^
        facebook.hashCode ^
        instgram.hashCode ^
        dynamicLink.hashCode ^
        whatsAppNum.hashCode ^
        region.hashCode ^
        city.hashCode ^
        rating.hashCode ^
        ismix.hashCode ^
        address.hashCode ^
        long.hashCode ^
        lat.hashCode;
  }
}
