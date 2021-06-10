import 'package:equatable/equatable.dart';

/// модель результата теста
class EcoTestResult extends Equatable {
  String id;
  String userId;
  String userName;
  String testId;
  String testName;
  int points;
  int pointsThreashold;
  bool isSuccess;

  EcoTestResult(
      {this.id,
      this.userId,
      this.userName,
      this.testId,
      this.testName,
      this.points,
      this.pointsThreashold,
      this.isSuccess});

  EcoTestResult.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    userName = json["user_name"];
    testId = json["test_id"];
    testName = json["test_name"];
    points = json["points"];
    pointsThreashold = json["points_threashold"];
    isSuccess = json["is_success"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["user_name"] = userName;
    map["test_id"] = testId;
    map["test_name"] = testName;
    map["points"] = points;
    map["points_threashold"] = pointsThreashold;
    map["is_success"] = isSuccess;
    return map;
  }

  @override
  List<Object> get props => [
        id,
        userId,
        userName,
        testId,
        testName,
        points,
        pointsThreashold,
        isSuccess,
      ];
}
