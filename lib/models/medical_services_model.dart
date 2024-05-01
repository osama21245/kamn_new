// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MedicalServicesModel {
  final String id;
  final String title;
  final String description;
  final String discount;
  MedicalServicesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
  });

  MedicalServicesModel copyWith({
    String? id,
    String? title,
    String? description,
    String? discount,
  }) {
    return MedicalServicesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'discount': discount,
    };
  }

  factory MedicalServicesModel.fromMap(Map<String, dynamic> map) {
    return MedicalServicesModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      discount: map['discount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalServicesModel.fromJson(String source) =>
      MedicalServicesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MedicalServicesModel(id: $id, title: $title, description: $description, discount: $discount)';
  }

  @override
  bool operator ==(covariant MedicalServicesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        discount.hashCode;
  }
}
