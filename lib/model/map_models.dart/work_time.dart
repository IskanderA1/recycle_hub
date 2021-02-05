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

  String getWorkingTime() {
    String monD = "ПН: ${mon[0]}-${mon[1]}  ${mon[2]}-${mon[3]}";
    String thuD = "ВТ: ${thu[0]}-${thu[1]}  ${thu[2]}-${thu[3]}";
    String wedD = "СР: ${wed[0]}-${wed[1]}  ${wed[2]}-${wed[3]}";
    String thrD = "ЧТ: ${thr[0]}-${thr[1]}  ${thr[2]}-${thr[3]}";
    String friD = "ПТ: ${fri[0]}-${fri[1]}  ${fri[2]}-${fri[3]}";
    String satD = "СБ: ${sat[0]}-${sat[1]}  ${sat[2]}-${sat[3]}";
    String sunD = "ВС: ${sun[0]}-${sun[1]}  ${sun[2]}-${sun[3]}";
    String newString = monD +
        "\n" +
        thuD +
        "\n" +
        wedD +
        "\n" +
        thrD +
        "\n" +
        friD +
        "\n" +
        satD +
        "\n" +
        sunD;
    return newString;
  }

  String getByInd(String i) {
    String retStr = "";
    switch (i) {
      case 'Monday':
        retStr = "${mon[0]}-${mon[3]}";
        break;
      case 'Tuesday':
        retStr = "${thu[0]}-${thu[3]}";
        break;
      case 'Wednesday':
        retStr = "${wed[0]}-${wed[3]}";
        break;
      case 'Thursday':
        retStr = "${thr[0]}-${thr[3]}";
        break;
      case 'Friday':
        retStr = "${fri[0]}-${fri[3]}";
        break;
      case 'Saturday':
        retStr = "${sat[0]}-${sat[3]}";
        break;
      case 'Sunday':
        retStr = "${sun[0]}-${sun[3]}";
        break;
    }
    return retStr;
  }

  String getByIndexSecondPart(int i) {
    if (i < 0 || i >= 7) {
      return "";
    }
    String retStr = "";
    switch (i) {
      case 0:
        retStr = "${mon[1]}\n${mon[2]}";
        break;
      case 1:
        retStr = "${thu[1]}\n${thu[2]}";
        break;
      case 2:
        retStr = "${wed[1]}\n${wed[2]}";
        break;
      case 3:
        retStr = "${thr[1]}\n${thr[2]}";
        break;
      case 4:
        retStr = "${fri[1]}\n${fri[2]}";
        break;
      case 5:
        retStr = "${sat[1]}\n${sat[2]}";
        break;
      case 6:
        retStr = "${sun[1]}\n${sun[2]}";
        break;
    }
    return retStr;
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
