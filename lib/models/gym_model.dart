// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GymModel {
  final String id;
  final String name;
  final bool ismix;
  final String image;
  final String userId;
  GymModel({
    required this.id,
    required this.name,
    required this.ismix,
    required this.image,
    required this.userId,
  });

  GymModel copyWith({
    String? id,
    String? name,
    bool? ismix,
    String? image,
    String? userId,
  }) {
    return GymModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ismix: ismix ?? this.ismix,
      image: image ?? this.image,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'ismix': ismix,
      'image': image,
      'userId': userId,
    };
  }

  factory GymModel.fromMap(Map<String, dynamic> map) {
    return GymModel(
      id: map['id'] as String,
      name: map['name'] as String,
      ismix: map['ismix'] as bool,
      image: map['image'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GymModel.fromJson(String source) =>
      GymModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GymModel(id: $id, name: $name, ismix: $ismix, image: $image, userId: $userId)';
  }

  @override
  bool operator ==(covariant GymModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.ismix == ismix &&
        other.image == image &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        ismix.hashCode ^
        image.hashCode ^
        userId.hashCode;
  }
}
