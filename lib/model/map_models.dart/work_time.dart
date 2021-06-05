import 'dart:convert';
import 'package:hive/hive.dart';

import 'work_day.dart';
part 'work_time.g.dart';

@HiveType(typeId: 4)
class WorkingTime {
  @HiveField(0)
  WorkDay mon;
  @HiveField(1)
  WorkDay thu;
  @HiveField(2)
  WorkDay wed;
  @HiveField(3)
  WorkDay thr;
  @HiveField(4)
  WorkDay fri;
  @HiveField(5)
  WorkDay sat;
  @HiveField(6)
  WorkDay sun;
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
    WorkDay mon,
    WorkDay thu,
    WorkDay wed,
    WorkDay thr,
    WorkDay fri,
    WorkDay sat,
    WorkDay sun,
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
      'mon': mon?.toMap(),
      'thu': thu?.toMap(),
      'wed': wed?.toMap(),
      'thr': thr?.toMap(),
      'fri': fri?.toMap(),
      'sat': sat?.toMap(),
      'sun': sun?.toMap(),
    };
  }

  String getWorkingTime() {
    String monD = "ПН: ${mon.toString()}";
    String thuD = "ВТ: ${thu.toString()}";
    String wedD = "СР: ${wed.toString()}";
    String thrD = "ЧТ: ${thr.toString()}";
    String friD = "ПТ: ${fri.toString()}";
    String satD = "СБ: ${sat.toString()}";
    String sunD = "ВС: ${sun.toString()}";
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

  factory WorkingTime.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WorkingTime(
      mon: WorkDay.fromMap(map['ПН']),
      thu: WorkDay.fromMap(map['ВТ']),
      wed: WorkDay.fromMap(map['СР']),
      thr: WorkDay.fromMap(map['ЧТ']),
      fri: WorkDay.fromMap(map['ПТ']),
      sat: WorkDay.fromMap(map['СБ']),
      sun: WorkDay.fromMap(map['ВС']),
    );
  }

  String getByInd(String i) {
    String retStr = "";
    switch (i) {
      case 'Monday':
        retStr = mon != null ? "${mon.first}-${mon.fourth}" : '--.--';
        break;
      case 'Tuesday':
        retStr = thu != null ? "${thu.first}-${thu.fourth}" : '--.--';
        break;
      case 'Wednesday':
        retStr = wed != null ? "${wed.first}-${wed.fourth}" : '--.--';
        break;
      case 'Thursday':
        retStr = thr != null ? "${thr.first}-${thr.fourth}" : '--.--';
        break;
      case 'Friday':
        retStr = fri != null ? "${fri.first}-${fri.fourth}" : '--.--';
        break;
      case 'Saturday':
        retStr = sat != null ? '${sat.first}-${sat.fourth}' : '--.--';
        break;
      case 'Sunday':
        retStr = sun != null ? "${sun.first}-${sun.fourth}" : '--.--';
        break;
    }
    return retStr;
  }

  String getByIndexSecondPart(int i) {
    if (i < 0 || i >= 7) {
      return "";
    }
    String retStr = "";
    WorkDay day;
    switch (i) {
      case 0:
        day = mon;
        break;
      case 1:
        day = thu;
        break;
      case 2:
        day = wed;
        break;
      case 3:
        day = thr;
        break;
      case 4:
        day = fri;
        break;
      case 5:
        day = sat;
        break;
      case 6:
        day = sun;
        break;
    }
    return day != null ? "${day.second}\n${day.third}" : '--.--';
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
        o.mon == mon &&
        o.thu == thu &&
        o.wed == wed &&
        o.thr == thr &&
        o.fri == fri &&
        o.sat == sat &&
        o.sun == sun;
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

/*String getWorkingTime() {
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
  } */
