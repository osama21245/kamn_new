// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OffersModel {
  final String id;
  final String title;
  final String description;
  final String discount;
  final String image;
  final DateTime date;
  OffersModel({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.image,
    required this.date,
  });

  OffersModel copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    String? discount,
    String? image,
    DateTime? date,
  }) {
    return OffersModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'discount': discount,
      'image': image,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory OffersModel.fromMap(Map<String, dynamic> map) {
    return OffersModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      discount: map['discount'] as String,
      image: map['image'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OffersModel.fromJson(String source) =>
      OffersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OffersModel(id: $id, title: $title, description: $description, discount: $discount, image: $image, date: $date)';
  }

  @override
  bool operator ==(covariant OffersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.discount == discount &&
        other.image == image &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        discount.hashCode ^
        image.hashCode ^
        date.hashCode;
  }
}
