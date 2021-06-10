import 'dart:convert';

import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/model/profile_models/eco_test_answer_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_question_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_result_model.dart';

const String kTest = 'tests';
const String kTestAttempts = 'attempts';
const String kTestQuestions = 'questions';

class ProfileRepository {
  ProfileRepository();

  Future<List<EcoTestModel>> getAllTest() async {
    try {
      var response = await CommonRequest.makeRequest(
        kTest,
        method: CommonRequestMethod.get,
      );
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        var list = <EcoTestModel>[];
        data.map((item) => list.add(EcoTestModel.fromJson(item)));
        return list;
      } else {
        throw Exception("Нет доступных тестов");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<EcoTestQuestionModel>> getQuestionsByEcoTestModel(
      String testId) async {
    try {
      var response = await CommonRequest.makeRequest(
        '$kTest/$testId/$kTestQuestions',
        method: CommonRequestMethod.get,
      );
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        var list = <EcoTestQuestionModel>[];
        data.map((item) => list.add(EcoTestQuestionModel.fromJson(item)));
        return list;
      } else {
        throw Exception("Список вопросов пуст");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<EcoTestResult> sendAttempt(
    String testId,
    List<EcoTestAnswerModel> answers,
  ) async {
    var body = {
      "answers": [...answers.map((e) => e.toJson()).toList()]
    };
    try {
      var response = await CommonRequest.makeRequest(
        '$kTest/$testId/$kTestAttempts',
        method: CommonRequestMethod.post,
        body: body,
      );
      var data = jsonDecode(response.body);
      if (data != null) {
        return EcoTestResult.fromJson(data);
      } else {
        throw Exception("Результаты неизвестны");
      }
    } catch (error) {
      rethrow;
    }
  }
}
