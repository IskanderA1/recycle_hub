// To parse this JSON data, do
//
//     final purchase = purchaseFromMap(jsonString);

import 'dart:convert';

class Purchase {
  Purchase({
    this.id,
    this.productId,
    this.productName,
    this.itemId,
    this.content,
    this.amount,
    this.daysRest,
    this.dateFrom,
    this.dateTo,
    this.buyDate,
    this.image,
  });

  String id;
  String productId;
  String productName;
  String itemId;
  String content;
  int amount;
  int daysRest;
  DateTime dateFrom;
  DateTime dateTo;
  DateTime buyDate;
  String image;

  Purchase copyWith({
    String id,
    String productId,
    String productName,
    String itemId,
    String content,
    int amount,
    int daysRest,
    DateTime dateFrom,
    DateTime dateTo,
    DateTime buyDate,
  }) =>
      Purchase(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        itemId: itemId ?? this.itemId,
        content: content ?? this.content,
        amount: amount ?? this.amount,
        daysRest: daysRest ?? this.daysRest,
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
        buyDate: buyDate ?? this.buyDate,
      );

  factory Purchase.fromJson(String str) => Purchase.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Purchase.fromMap(Map<String, dynamic> json) => Purchase(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        itemId: json["item_id"],
        content: json["content"],
        amount: json["amount"],
        daysRest: json["days_rest"],
        dateFrom: DateTime.parse(json["date_from"]),
        dateTo: DateTime.parse(json["date_to"]),
        buyDate: DateTime.parse(
          json["buy_date"],
        ),
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "item_id": itemId,
        "content": content,
        "amount": amount,
        "days_rest": daysRest,
        "date_from":
            "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
        "date_to": "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
        "buy_date": buyDate.toIso8601String(),
        "image": image,
      };
}
