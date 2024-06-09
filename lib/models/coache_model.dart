// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class CoacheModel {
  final String id;
  final String name;
  final String userId;
  final double rating;
  final String image;
  final String education;
  final String whatsAppNum;
  final String faceBook;
  final String instgram;
  final String dynamicLink;
  final List<dynamic> onlineSpecial;
  final List<dynamic> onlinepoints;
  final List<dynamic> onlineprices;
  final List<dynamic> onlineplanDescriptions;
  final List<dynamic> onlinePlanName;
  final List<dynamic> onlinediscount;
  final List<dynamic> onlineisGroup;
  final List<dynamic> onlineReservisionTimes;
  final List<dynamic> offlineSpecial;
  final List<dynamic> offlinepoints;
  final List<dynamic> offlineprices;
  final List<dynamic> offlineplanDescriptions;
  final List<dynamic> offlinePlanName;
  final List<dynamic> offlinediscount;
  final List<dynamic> offlineisGroup;
  final List<dynamic> offlineReservisionTimes;
  final String categoriry;
  final String experience;
  final String benefits;
  final List<dynamic> gallery;
  CoacheModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.rating,
    required this.image,
    required this.education,
    required this.whatsAppNum,
    required this.faceBook,
    required this.instgram,
    required this.dynamicLink,
    required this.onlineSpecial,
    required this.onlinepoints,
    required this.onlineprices,
    required this.onlineplanDescriptions,
    required this.onlinePlanName,
    required this.onlinediscount,
    required this.onlineisGroup,
    required this.onlineReservisionTimes,
    required this.offlineSpecial,
    required this.offlinepoints,
    required this.offlineprices,
    required this.offlineplanDescriptions,
    required this.offlinePlanName,
    required this.offlinediscount,
    required this.offlineisGroup,
    required this.offlineReservisionTimes,
    required this.categoriry,
    required this.experience,
    required this.benefits,
    required this.gallery,
  });

  CoacheModel copyWith({
    String? id,
    String? name,
    String? userId,
    double? rating,
    String? image,
    String? education,
    String? whatsAppNum,
    String? faceBook,
    String? instgram,
    String? dynamicLink,
    List<dynamic>? onlineSpecial,
    List<dynamic>? onlinepoints,
    List<dynamic>? onlineprices,
    List<dynamic>? onlineplanDescriptions,
    List<dynamic>? onlinePlanName,
    List<dynamic>? onlinediscount,
    List<dynamic>? onlineisGroup,
    List<dynamic>? onlineReservisionTimes,
    List<dynamic>? offlineSpecial,
    List<dynamic>? offlinepoints,
    List<dynamic>? offlineprices,
    List<dynamic>? offlineplanDescriptions,
    List<dynamic>? offlinePlanName,
    List<dynamic>? offlinediscount,
    List<dynamic>? offlineisGroup,
    List<dynamic>? offlineReservisionTimes,
    String? categoriry,
    String? experience,
    String? benefits,
    List<dynamic>? gallery,
  }) {
    return CoacheModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      education: education ?? this.education,
      whatsAppNum: whatsAppNum ?? this.whatsAppNum,
      faceBook: faceBook ?? this.faceBook,
      instgram: instgram ?? this.instgram,
      dynamicLink: dynamicLink ?? this.dynamicLink,
      onlineSpecial: onlineSpecial ?? this.onlineSpecial,
      onlinepoints: onlinepoints ?? this.onlinepoints,
      onlineprices: onlineprices ?? this.onlineprices,
      onlineplanDescriptions:
          onlineplanDescriptions ?? this.onlineplanDescriptions,
      onlinePlanName: onlinePlanName ?? this.onlinePlanName,
      onlinediscount: onlinediscount ?? this.onlinediscount,
      onlineisGroup: onlineisGroup ?? this.onlineisGroup,
      onlineReservisionTimes:
          onlineReservisionTimes ?? this.onlineReservisionTimes,
      offlineSpecial: offlineSpecial ?? this.offlineSpecial,
      offlinepoints: offlinepoints ?? this.offlinepoints,
      offlineprices: offlineprices ?? this.offlineprices,
      offlineplanDescriptions:
          offlineplanDescriptions ?? this.offlineplanDescriptions,
      offlinePlanName: offlinePlanName ?? this.offlinePlanName,
      offlinediscount: offlinediscount ?? this.offlinediscount,
      offlineisGroup: offlineisGroup ?? this.offlineisGroup,
      offlineReservisionTimes:
          offlineReservisionTimes ?? this.offlineReservisionTimes,
      categoriry: categoriry ?? this.categoriry,
      experience: experience ?? this.experience,
      benefits: benefits ?? this.benefits,
      gallery: gallery ?? this.gallery,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'rating': rating,
      'image': image,
      'education': education,
      'whatsAppNum': whatsAppNum,
      'faceBook': faceBook,
      'instgram': instgram,
      'dynamicLink': dynamicLink,
      'onlineSpecial': onlineSpecial,
      'onlinepoints': onlinepoints,
      'onlineprices': onlineprices,
      'onlineplanDescriptions': onlineplanDescriptions,
      'onlinePlanName': onlinePlanName,
      'onlinediscount': onlinediscount,
      'onlineisGroup': onlineisGroup,
      'onlineReservisionTimes': onlineReservisionTimes,
      'offlineSpecial': offlineSpecial,
      'offlinepoints': offlinepoints,
      'offlineprices': offlineprices,
      'offlineplanDescriptions': offlineplanDescriptions,
      'offlinePlanName': offlinePlanName,
      'offlinediscount': offlinediscount,
      'offlineisGroup': offlineisGroup,
      'offlineReservisionTimes': offlineReservisionTimes,
      'categoriry': categoriry,
      'experience': experience,
      'benefits': benefits,
      'gallery': gallery,
    };
  }

  factory CoacheModel.fromMap(Map<String, dynamic> map) {
    return CoacheModel(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['userId'] as String,
      rating: map['rating'] as double,
      image: map['image'] as String,
      education: map['education'] as String,
      whatsAppNum: map['whatsAppNum'] as String,
      faceBook: map['faceBook'] as String,
      instgram: map['instgram'] as String,
      dynamicLink: map['dynamicLink'] as String,
      onlineSpecial:
          List<dynamic>.from((map['onlineSpecial'] as List<dynamic>)),
      onlinepoints: List<dynamic>.from((map['onlinepoints'] as List<dynamic>)),
      onlineprices: List<dynamic>.from((map['onlineprices'] as List<dynamic>)),
      onlineplanDescriptions:
          List<dynamic>.from((map['onlineplanDescriptions'] as List<dynamic>)),
      onlinePlanName:
          List<dynamic>.from((map['onlinePlanName'] as List<dynamic>)),
      onlinediscount:
          List<dynamic>.from((map['onlinediscount'] as List<dynamic>)),
      onlineisGroup:
          List<dynamic>.from((map['onlineisGroup'] as List<dynamic>)),
      onlineReservisionTimes:
          List<dynamic>.from((map['onlineReservisionTimes'] as List<dynamic>)),
      offlineSpecial:
          List<dynamic>.from((map['offlineSpecial'] as List<dynamic>)),
      offlinepoints:
          List<dynamic>.from((map['offlinepoints'] as List<dynamic>)),
      offlineprices:
          List<dynamic>.from((map['offlineprices'] as List<dynamic>)),
      offlineplanDescriptions:
          List<dynamic>.from((map['offlineplanDescriptions'] as List<dynamic>)),
      offlinePlanName:
          List<dynamic>.from((map['offlinePlanName'] as List<dynamic>)),
      offlinediscount:
          List<dynamic>.from((map['offlinediscount'] as List<dynamic>)),
      offlineisGroup:
          List<dynamic>.from((map['offlineisGroup'] as List<dynamic>)),
      offlineReservisionTimes:
          List<dynamic>.from((map['offlineReservisionTimes'] as List<dynamic>)),
      categoriry: map['categoriry'] as String,
      experience: map['experience'] as String,
      benefits: map['benefits'] as String,
      gallery: List<dynamic>.from((map['gallery'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory CoacheModel.fromJson(String source) =>
      CoacheModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CoacheModel(id: $id, name: $name, userId: $userId, rating: $rating, image: $image, education: $education, whatsAppNum: $whatsAppNum, faceBook: $faceBook, instgram: $instgram, dynamicLink: $dynamicLink, onlineSpecial: $onlineSpecial, onlinepoints: $onlinepoints, onlineprices: $onlineprices, onlineplanDescriptions: $onlineplanDescriptions, onlinePlanName: $onlinePlanName, onlinediscount: $onlinediscount, onlineisGroup: $onlineisGroup, onlineReservisionTimes: $onlineReservisionTimes, offlineSpecial: $offlineSpecial, offlinepoints: $offlinepoints, offlineprices: $offlineprices, offlineplanDescriptions: $offlineplanDescriptions, offlinePlanName: $offlinePlanName, offlinediscount: $offlinediscount, offlineisGroup: $offlineisGroup, offlineReservisionTimes: $offlineReservisionTimes, categoriry: $categoriry, experience: $experience, benefits: $benefits, gallery: $gallery)';
  }

  @override
  bool operator ==(covariant CoacheModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        other.rating == rating &&
        other.image == image &&
        other.education == education &&
        other.whatsAppNum == whatsAppNum &&
        other.faceBook == faceBook &&
        other.instgram == instgram &&
        other.dynamicLink == dynamicLink &&
        listEquals(other.onlineSpecial, onlineSpecial) &&
        listEquals(other.onlinepoints, onlinepoints) &&
        listEquals(other.onlineprices, onlineprices) &&
        listEquals(other.onlineplanDescriptions, onlineplanDescriptions) &&
        listEquals(other.onlinePlanName, onlinePlanName) &&
        listEquals(other.onlinediscount, onlinediscount) &&
        listEquals(other.onlineisGroup, onlineisGroup) &&
        listEquals(other.onlineReservisionTimes, onlineReservisionTimes) &&
        listEquals(other.offlineSpecial, offlineSpecial) &&
        listEquals(other.offlinepoints, offlinepoints) &&
        listEquals(other.offlineprices, offlineprices) &&
        listEquals(other.offlineplanDescriptions, offlineplanDescriptions) &&
        listEquals(other.offlinePlanName, offlinePlanName) &&
        listEquals(other.offlinediscount, offlinediscount) &&
        listEquals(other.offlineisGroup, offlineisGroup) &&
        listEquals(other.offlineReservisionTimes, offlineReservisionTimes) &&
        other.categoriry == categoriry &&
        other.experience == experience &&
        other.benefits == benefits &&
        listEquals(other.gallery, gallery);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        rating.hashCode ^
        image.hashCode ^
        education.hashCode ^
        whatsAppNum.hashCode ^
        faceBook.hashCode ^
        instgram.hashCode ^
        dynamicLink.hashCode ^
        onlineSpecial.hashCode ^
        onlinepoints.hashCode ^
        onlineprices.hashCode ^
        onlineplanDescriptions.hashCode ^
        onlinePlanName.hashCode ^
        onlinediscount.hashCode ^
        onlineisGroup.hashCode ^
        onlineReservisionTimes.hashCode ^
        offlineSpecial.hashCode ^
        offlinepoints.hashCode ^
        offlineprices.hashCode ^
        offlineplanDescriptions.hashCode ^
        offlinePlanName.hashCode ^
        offlinediscount.hashCode ^
        offlineisGroup.hashCode ^
        offlineReservisionTimes.hashCode ^
        categoriry.hashCode ^
        experience.hashCode ^
        benefits.hashCode ^
        gallery.hashCode;
  }
}
