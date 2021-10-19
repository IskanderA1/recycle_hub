// To parse this JSON data, do
//
//     final usersCountModel = usersCountModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UsersCountModel {
    UsersCountModel({
        @required this.usersCount,
    });

    final int usersCount;

    UsersCountModel copyWith({
        int usersCount,
    }) => 
        UsersCountModel(
            usersCount: usersCount ?? this.usersCount,
        );

    factory UsersCountModel.fromJson(String str) => UsersCountModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsersCountModel.fromMap(Map<String, dynamic> json) => UsersCountModel(
        usersCount: json["users_count"],
    );

    Map<String, dynamic> toMap() => {
        "users_count": usersCount,
    };
}
