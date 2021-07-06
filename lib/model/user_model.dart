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
    this.freezeEcoCoins,
    this.token,
    this.inviteCode,
    this.role,
    this.attachedRecPointId,
    this.image,
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
  @HiveField(5)
  int freezeEcoCoins;
  @HiveField(6)
  String token;
  @HiveField(7)
  String inviteCode;
  @HiveField(8)
  String role;
  @HiveField(9)
  String attachedRecPointId;
  @HiveField(10)
  String image;

  UserModel copyWith({
    String id,
    String username,
    String name,
    bool confirmed,
    int ecoCoins,
    int freezeEcoCoins,
    String token,
    String inviteCode,
    String role,
    String attachedRecPointId,
    String image,
  }) =>
      UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        name: name ?? this.name,
        confirmed: confirmed ?? this.confirmed,
        ecoCoins: ecoCoins ?? this.ecoCoins,
        freezeEcoCoins: freezeEcoCoins ?? this.freezeEcoCoins,
        token: token ?? this.token,
        inviteCode: inviteCode ?? this.inviteCode,
        role: role ?? this.role,
        attachedRecPointId: attachedRecPointId ?? this.attachedRecPointId,
        image: image ?? this.image,
      );

  factory UserModel.guestAcc() => UserModel(
        id: '__',
        username: "guest@gmail.com",
        name: 'Гость',
        confirmed: true,
        ecoCoins: 0,
        freezeEcoCoins: 0,
        token: '__',
        inviteCode: '__',
        role: '__',
        attachedRecPointId: '__',
        image: null,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        name: json["name"] == null ? null : json["name"],
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        ecoCoins: json["eco_coins"] == null ? null : json["eco_coins"],
        freezeEcoCoins:
            json["freeze_eco_coins"] == null ? null : json["freeze_eco_coins"],
        token: json["token"] == null ? null : json["token"],
        inviteCode: json["invite_code"] == null ? null : json["invite_code"],
        role: json["role"] == null ? null : json["role"],
        attachedRecPointId: json["attached_rec_point_id"] == null
            ? null
            : json["attached_rec_point_id"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "name": name == null ? null : name,
        "confirmed": confirmed == null ? null : confirmed,
        "eco_coins": ecoCoins == null ? null : ecoCoins,
        "freeze_eco_coins": freezeEcoCoins == null ? null : freezeEcoCoins,
        "token": token == null ? null : token,
        "invite_code": inviteCode == null ? null : inviteCode,
        "role": role == null ? null : role,
        "attached_rec_point_id":
            attachedRecPointId == null ? null : attachedRecPointId,
        "image": image == null ? null : image,
      };
}
