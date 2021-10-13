// To parse this JSON data, do
//
//     final userStatistic = userStatisticFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:recycle_hub/model/user_statistic_item.dart';

class UserStatistic {
  int place;
  int total;
  int usersCount;
  List<UserStatisticItem> items;
  UserStatistic({
    @required this.place,
    @required this.total,
    @required this.usersCount,
    @required this.items,
  });

  UserStatistic copyWith({
    int place,
    int total,
    int usersCount,
    List<UserStatisticItem> items,
  }) {
    return UserStatistic(
      place: place ?? this.place,
      total: total ?? this.total,
      usersCount: usersCount ?? this.usersCount,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'place': place,
      'total': total,
      'users_count': usersCount,
      'items': items?.map((x) => x.toMap())?.toList(),
    };
  }

  factory UserStatistic.fromMap(Map<String, dynamic> map) {
    return UserStatistic(
      place: map['place'],
      total: map['total'],
      usersCount: map['users_count'],
      items: List<UserStatisticItem>.from(map['items']?.map((x) => UserStatisticItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStatistic.fromJson(String source) => UserStatistic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserStatistic(place: $place, total: $total, users_count: $usersCount, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserStatistic &&
        other.place == place &&
        other.total == total &&
        other.usersCount == usersCount &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return place.hashCode ^ total.hashCode ^ usersCount.hashCode ^ items.hashCode;
  }
}
