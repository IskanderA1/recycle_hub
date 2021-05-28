// To parse this JSON data, do
//
//     final member = memberFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  UserModel({
    this.id,
    this.username,
    this.name,
    this.confirmed,
    this.ecoCoins,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String username;
  @HiveField(2)
  String name;
  @HiveField(3)
  bool confirmed;
  @HiveField(4)
  int ecoCoins;

  UserModel copyWith({
    String id,
    String username,
    String name,
    bool confirmed,
    int ecoCoins,
  }) =>
      UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        name: name ?? this.name,
        confirmed: confirmed ?? this.confirmed,
        ecoCoins: ecoCoins ?? this.ecoCoins,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        confirmed: json["confirmed"],
        ecoCoins: json["eco_coins"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "name": name,
        "confirmed": confirmed,
        "eco_coins": ecoCoins,
      };
}
