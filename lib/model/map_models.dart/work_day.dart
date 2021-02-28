import 'dart:convert';

class WorkDay {
  String first;
  String second;
  String third;
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

  factory WorkDay.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WorkDay(
      first: map['0'],
      second: map['1'],
      third: map['2'],
      fourth: map['3'],
    );
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
