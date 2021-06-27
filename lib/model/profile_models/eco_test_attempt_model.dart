// To parse this JSON data, do
//
//     final attempt = attemptFromMap(jsonString);

import 'dart:convert';

import 'package:recycle_hub/model/profile_models/eco_test_question_model.dart';

class Attempt {
  Attempt({
    this.id,
    this.testId,
    this.testName,
    this.points,
    this.pointsThreshold,
    this.isSuccess,
    this.isClosed,
    this.datetimeOpened,
    this.datetimeClosed,
    this.questions,
  });

  String id;
  String testId;
  String testName;
  int points;
  int pointsThreshold;
  bool isSuccess;
  bool isClosed;
  DateTime datetimeOpened;
  dynamic datetimeClosed;
  List<Question> questions;

  Attempt copyWith({
    String id,
    String testId,
    String testName,
    int points,
    int pointsThreshold,
    bool isSuccess,
    bool isClosed,
    DateTime datetimeOpened,
    dynamic datetimeClosed,
    List<Question> questions,
  }) =>
      Attempt(
        id: id ?? this.id,
        testId: testId ?? this.testId,
        testName: testName ?? this.testName,
        points: points ?? this.points,
        pointsThreshold: pointsThreshold ?? this.pointsThreshold,
        isSuccess: isSuccess ?? this.isSuccess,
        isClosed: isClosed ?? this.isClosed,
        datetimeOpened: datetimeOpened ?? this.datetimeOpened,
        datetimeClosed: datetimeClosed ?? this.datetimeClosed,
        questions: questions ?? this.questions,
      );

  factory Attempt.fromJson(String str) => Attempt.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attempt.fromMap(Map<String, dynamic> json) => Attempt(
        id: json["id"],
        testId: json["test_id"],
        testName: json["test_name"],
        points: json["points"],
        pointsThreshold: json["points_threshold"],
        isSuccess: json["is_success"],
        isClosed: json["is_closed"],
        datetimeOpened: DateTime.parse(json["datetime_opened"]),
        datetimeClosed: json["datetime_closed"],
        questions: json["questions"] == null ? null : List<Question>.from(json["questions"].map((x) => Question.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "test_id": testId,
        "test_name": testName,
        "points": points,
        "points_threshold": pointsThreshold,
        "is_success": isSuccess,
        "is_closed": isClosed,
        "datetime_opened": datetimeOpened.toIso8601String(),
        "datetime_closed": datetimeClosed,
        "questions": questions == null ? null : List<dynamic>.from(questions.map((x) => x.toMap())),
      };
}
