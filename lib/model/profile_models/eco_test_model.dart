import 'package:equatable/equatable.dart';
import 'package:recycle_hub/model/profile_models/eco_test_question_model.dart';

/// модель теста, по [id] можно догрузить [questions]
class EcoTestModel extends Equatable {
  String id;
  String testName;
  String description;
  int coinsToUnlock;
  int pointsToSuccess;
  List<EcoTestQuestionModel> questions;

  EcoTestModel(
      {this.id,
      this.testName,
      this.description,
      this.coinsToUnlock,
      this.pointsToSuccess});

  EcoTestModel.fromJson(dynamic json) {
    id = json["id"];
    testName = json["test_name"];
    description = json["description"];
    coinsToUnlock = json["coins_to_unlock"];
    pointsToSuccess = json["points_to_success"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["test_name"] = testName;
    map["description"] = description;
    map["coins_to_unlock"] = coinsToUnlock;
    map["points_to_success"] = pointsToSuccess;
    return map;
  }

  @override
  List<Object> get props => [
        id,
        testName,
        description,
        coinsToUnlock,
        pointsToSuccess,
      ];
}
