// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.count,
    this.dateFrom,
    this.dateTo,
    this.daysRest,
    this.image,
  });

  String id;
  String name;
  int price;
  int count;
  DateTime dateFrom;
  DateTime dateTo;
  int daysRest;
  String image;

  Product copyWith({
    String id,
    String name,
    int price,
    int count,
    DateTime dateFrom,
    DateTime dateTo,
    int daysRest,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        count: count ?? this.count,
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
        daysRest: daysRest ?? this.daysRest,
      );

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        count: json["count"],
        dateFrom: DateTime.parse(json["date_from"]),
        dateTo: DateTime.parse(json["date_to"]),
        daysRest: json["days_rest"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "count": count,
        "date_from": dateFrom.toIso8601String(),
        "date_to": dateTo.toIso8601String(),
        "days_rest": daysRest,
      };
}
