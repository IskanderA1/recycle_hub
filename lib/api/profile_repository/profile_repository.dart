import 'dart:convert';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/model/api_error.dart';
import 'package:recycle_hub/model/profile_models/eco_test_answer_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_attempt_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_item_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_result_model.dart';

const String kTest = 'tests';
const String kTestAttempts = 'attempts';
const String kAttempt = 'attempts';

class ProfileRepository {
  ProfileRepository();

  /* Future<List<TestItem>> getAllTest() async {
    try {
      var response = await CommonRequest.makeRequest(
        kTest,
        method: CommonRequestMethod.get,
      );
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        var list = <TestItem>[];
        data.map((item) => list.add(TestItem.fromJson(item)));
        return list;
      } else {
        throw Exception("Нет доступных тестов");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Attempt>> getAttempts(
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
  } */

  /* Future<EcoTestResult> sendAttempt(
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
  } */

  Future<Attempt> getAttempt(String testId) async {
    try {
      var response = await CommonRequest.makeRequest(
        '$kTest/$testId/$kAttempt',
        method: CommonRequestMethod.get,
      );
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if (data.isNotEmpty) {
          return Attempt.fromMap(data);
        } else {
          throw Exception("Список вопросов пуст");
        }
      } else if (response.statusCode == 400) {
        if (data['error'] != null &&
            data['error'] ==
                "not enough time has passed since the last attempt") {
          throw ApiError(
              statusCode: 400,
              type: ApiErrorType.testUnavailable,
              errorDescription:
                  'Тест уже пройден, следующая попытка будет доступна позднее');
        }
        throw Exception(response.reasonPhrase);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TestItem>> getTests() async {
    try {
      final response = await CommonRequest.makeRequest(kTest);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<TestItem> tests = List.from(data.map((e) => TestItem.fromMap(e)));
        return tests;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AnswerResult> sendAnswer(
      {EcoTestAnswerModel answer, String testId, String attemptId}) async {
    try {
      final response = await CommonRequest.makeRequest(
          '$kTest/$testId/$kAttempt/$attemptId/answer',
          body: answer.toJson(),
          method: CommonRequestMethod.post);
      if (response.statusCode == 201) {
        return AnswerResult.fromJson(response.body);
      } else {
        throw ApiError(
            type: ApiErrorType.unknown, statusCode: response.statusCode);
      }
    } catch (e) {
      rethrow;
    }
  }
}
