import 'dart:convert';

class WorkingDaysModel {
  DayModel day1;
  DayModel day2;
  DayModel day3;
  DayModel day4;
  DayModel day5;
  DayModel day6;
  DayModel day7;
  WorkingDaysModel({
    this.day1,
    this.day2,
    this.day3,
    this.day4,
    this.day5,
    this.day6,
    this.day7,
  });

  WorkingDaysModel copyWith({
    DayModel day1,
    DayModel day2,
    DayModel day3,
    DayModel day4,
    DayModel day5,
    DayModel day6,
    DayModel day7,
  }) {
    return WorkingDaysModel(
      day1: day1 ?? this.day1,
      day2: day2 ?? this.day2,
      day3: day3 ?? this.day3,
      day4: day4 ?? this.day4,
      day5: day5 ?? this.day5,
      day6: day6 ?? this.day6,
      day7: day7 ?? this.day7,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day1': day1?.toMap(),
      'day2': day2?.toMap(),
      'day3': day3?.toMap(),
      'day4': day4?.toMap(),
      'day5': day5?.toMap(),
      'day6': day6?.toMap(),
      'day7': day7?.toMap(),
    };
  }

  factory WorkingDaysModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WorkingDaysModel(
      day1: DayModel.fromMap(map['day1']),
      day2: DayModel.fromMap(map['day2']),
      day3: DayModel.fromMap(map['day3']),
      day4: DayModel.fromMap(map['day4']),
      day5: DayModel.fromMap(map['day5']),
      day6: DayModel.fromMap(map['day6']),
      day7: DayModel.fromMap(map['day7']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkingDaysModel.fromJson(String source) =>
      WorkingDaysModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WorkingDaysModel(day1: $day1, day2: $day2, day3: $day3, day4: $day4, day5: $day5, day6: $day6, day7: $day7)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WorkingDaysModel &&
        o.day1 == day1 &&
        o.day2 == day2 &&
        o.day3 == day3 &&
        o.day4 == day4 &&
        o.day5 == day5 &&
        o.day6 == day6 &&
        o.day7 == day7;
  }

  @override
  int get hashCode {
    return day1.hashCode ^
        day2.hashCode ^
        day3.hashCode ^
        day4.hashCode ^
        day5.hashCode ^
        day6.hashCode ^
        day7.hashCode;
  }
}

class DayModel {
  String dayId;
  String startWork;
  String finishWork;
  String startBreak;
  String finishBreak;
  DayModel({
    this.dayId,
    this.startWork,
    this.finishWork,
    this.startBreak,
    this.finishBreak,
  });

  DayModel copyWith({
    String dayId,
    String startWork,
    String finishWork,
    String startBreak,
    String finishBreak,
  }) {
    return DayModel(
      dayId: dayId ?? this.dayId,
      startWork: startWork ?? this.startWork,
      finishWork: finishWork ?? this.finishWork,
      startBreak: startBreak ?? this.startBreak,
      finishBreak: finishBreak ?? this.finishBreak,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayId': dayId,
      'startWork': startWork,
      'finishWork': finishWork,
      'startBreak': startBreak,
      'finishBreak': finishBreak,
    };
  }

  factory DayModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DayModel(
      dayId: map['dayId'],
      startWork: map['startWork'],
      finishWork: map['finishWork'],
      startBreak: map['startBreak'],
      finishBreak: map['finishBreak'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DayModel.fromJson(String source) =>
      DayModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DayModel(dayId: $dayId, startWork: $startWork, finishWork: $finishWork, startBreak: $startBreak, finishBreak: $finishBreak)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DayModel &&
        o.dayId == dayId &&
        o.startWork == startWork &&
        o.finishWork == finishWork &&
        o.startBreak == startBreak &&
        o.finishBreak == finishBreak;
  }

  @override
  int get hashCode {
    return dayId.hashCode ^
        startWork.hashCode ^
        finishWork.hashCode ^
        startBreak.hashCode ^
        finishBreak.hashCode;
  }
}
