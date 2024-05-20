// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InBoxModel {
  final String id;
  final String title;
  final String description;
  final String userId;
  final String image;
  final DateTime sentAt;
  InBoxModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.image,
    required this.sentAt,
  });

  InBoxModel copyWith({
    String? id,
    String? title,
    String? description,
    String? userId,
    String? image,
    DateTime? sentAt,
  }) {
    return InBoxModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      image: image ?? this.image,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'userId': userId,
      'image': image,
      'sentAt': sentAt.millisecondsSinceEpoch,
    };
  }

  factory InBoxModel.fromMap(Map<String, dynamic> map) {
    return InBoxModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      userId: map['userId'] as String,
      image: map['image'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory InBoxModel.fromJson(String source) =>
      InBoxModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InBoxModel(id: $id, title: $title, description: $description, userId: $userId, image: $image, sentAt: $sentAt)';
  }

  @override
  bool operator ==(covariant InBoxModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.userId == userId &&
        other.image == image &&
        other.sentAt == sentAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        userId.hashCode ^
        image.hashCode ^
        sentAt.hashCode;
  }
}
