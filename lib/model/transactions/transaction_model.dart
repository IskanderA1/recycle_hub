import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import '../user_model.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 7)
class TransactionModel {
  @HiveField(0)
  UserModel recUser;
  @HiveField(1)
  String id;
  @HiveField(2)
  CustMarker recPoint;
  @HiveField(3)
  int ammount;
  //TODO: Добавить поле фильтр тайп
  @HiveField(4)
  String image;
  @HiveField(5)
  int reward;
  TransactionModel({
    @required this.recUser,
    @required this.id,
    @required this.recPoint,
    @required this.ammount,
    @required this.image,
    @required this.reward,
  });

  TransactionModel copyWith({
    UserModel recUser,
    String id,
    CustMarker recPoint,
    int ammount,
    String image,
    int reward,
  }) {
    return TransactionModel(
      recUser: recUser ?? this.recUser,
      id: id ?? this.id,
      recPoint: recPoint ?? this.recPoint,
      ammount: ammount ?? this.ammount,
      image: image ?? this.image,
      reward: reward ?? this.reward,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_from': recUser.toMap(),
      '_id': id,
      '_to': recPoint.toMap(),
      'ammount': ammount,
      'image': image,
      'reward': reward,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      recUser: UserModel.fromMap(map['_from']),
      id: map['_id'],
      recPoint: CustMarker.fromMap(map['_to']),
      ammount: map['ammount'],
      image: map['image'],
      reward: map['reward'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(recUser: $recUser, id: $id, recPoint: $recPoint, ammount: $ammount, image: $image, reward: $reward)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.recUser == recUser &&
        other.id == id &&
        other.recPoint == recPoint &&
        other.ammount == ammount &&
        other.image == image &&
        other.reward == reward;
  }

  @override
  int get hashCode {
    return recUser.hashCode ^
        id.hashCode ^
        recPoint.hashCode ^
        ammount.hashCode ^
        image.hashCode ^
        reward.hashCode;
  }
}
