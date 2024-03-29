import 'dart:convert';
import 'package:hive/hive.dart';
part 'work_day.g.dart';

@HiveType(typeId: 5)
class WorkDay {
  @HiveField(0)
  String first;
  @HiveField(1)
  String second;
  @HiveField(2)
  String third;
  @HiveField(3)
  String fourth;
  WorkDay({
    this.first,
    this.second,
    this.third,
    this.fourth,
  });

  WorkDay copyWith({
    String first,
    String second,
    String third,
    String fourth,
  }) {
    return WorkDay(
      first: first ?? this.first,
      second: second ?? this.second,
      third: third ?? this.third,
      fourth: fourth ?? this.fourth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first': first,
      'second': second,
      'third': third,
      'fourth': fourth,
    };
  }

  factory WorkDay.fromMap(var map) {
    if (map == null) return null;
    try {
      return WorkDay(
        first: map[0],
        second: map[1],
        third: map[2],
        fourth: map[3],
      );
    } catch (e) {
      return WorkDay(
        first: '--',
        second: '--',
        third: '--',
        fourth: '--',
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory WorkDay.fromJson(String source) =>
      WorkDay.fromMap(json.decode(source));

  @override
  String toString() {
    return '$first-$second  $third-$fourth';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WorkDay &&
        o.first == first &&
        o.second == second &&
        o.third == third &&
        o.fourth == fourth;
  }

  @override
  int get hashCode {
    return first.hashCode ^ second.hashCode ^ third.hashCode ^ fourth.hashCode;
  }
}
