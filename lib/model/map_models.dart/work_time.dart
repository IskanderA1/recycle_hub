import 'dart:convert';

import 'package:flutter/foundation.dart';

class WorkingTime {
  List<String> mon;
  List<String> thu;
  List<String> wed;
  List<String> thr;
  List<String> fri;
  List<String> sat;
  List<String> sun;

  WorkingTime({
    this.mon,
    this.thu,
    this.wed,
    this.thr,
    this.fri,
    this.sat,
    this.sun,
  });

  WorkingTime copyWith({
    List<String> mon,
    List<String> thu,
    List<String> wed,
    List<String> thr,
    List<String> fri,
    List<String> sat,
    List<String> sun,
  }) {
    return WorkingTime(
      mon: mon ?? this.mon,
      thu: thu ?? this.thu,
      wed: wed ?? this.wed,
      thr: thr ?? this.thr,
      fri: fri ?? this.fri,
      sat: sat ?? this.sat,
      sun: sun ?? this.sun,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mon': mon,
      'thu': thu,
      'wed': wed,
      'thr': thr,
      'fri': fri,
      'sat': sat,
      'sun': sun,
    };
  }

  factory WorkingTime.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WorkingTime(
      mon: List<String>.from(map['ПН']),
      thu: List<String>.from(map['ВТ']),
      wed: List<String>.from(map['СР']),
      thr: List<String>.from(map['ЧТ']),
      fri: List<String>.from(map['ПТ']),
      sat: List<String>.from(map['СБ']),
      sun: List<String>.from(map['ВС']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkingTime.fromJson(String source) =>
      WorkingTime.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WorkingTime(mon: $mon, thu: $thu, wed: $wed, thr: $thr, fri: $fri, sat: $sat, sun: $sun)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WorkingTime &&
        listEquals(o.mon, mon) &&
        listEquals(o.thu, thu) &&
        listEquals(o.wed, wed) &&
        listEquals(o.thr, thr) &&
        listEquals(o.fri, fri) &&
        listEquals(o.sat, sat) &&
        listEquals(o.sun, sun);
  }

  @override
  int get hashCode {
    return mon.hashCode ^
        thu.hashCode ^
        wed.hashCode ^
        thr.hashCode ^
        fri.hashCode ^
        sat.hashCode ^
        sun.hashCode;
  }
}
