// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OffersItemsModel {
  final String id;
  final String title;
  final String price;
  final String discount;
  final String image;
  final DateTime date;
  OffersItemsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.image,
    required this.date,
  });

  OffersItemsModel copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    String? discount,
    String? image,
    DateTime? date,
  }) {
    return OffersItemsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'discount': discount,
      'image': image,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory OffersItemsModel.fromMap(Map<String, dynamic> map) {
    return OffersItemsModel(
      id: map['id'] as String,
      title: map['title'] as String,
      price: map['price'] as String,
      discount: map['discount'] as String,
      image: map['image'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OffersItemsModel.fromJson(String source) =>
      OffersItemsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OffersModel(id: $id, title: $title, price: $price, discount: $discount, image: $image, date: $date)';
  }

  @override
  bool operator ==(covariant OffersItemsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.discount == discount &&
        other.image == image &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        discount.hashCode ^
        image.hashCode ^
        date.hashCode;
  }
}
