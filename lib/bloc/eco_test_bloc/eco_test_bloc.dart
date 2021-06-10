import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:recycle_hub/api/profile_repository/profile_repository.dart';
import 'package:recycle_hub/model/profile_models/eco_test_answer_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_question_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_result_model.dart';

part 'eco_test_event.dart';

part 'eco_test_state.dart';

/// блок для работы с тестами
class EcoTestBloc extends Bloc<EcoTestEvent, EcoTestState> {
  final ProfileRepository _profileRepository;

  EcoTestBloc(this._profileRepository)
      : super(EcoTestInitializedState(
          tests: [],
          currentTest: null,
          currentQuestion: null,
        ));

  final List<EcoTestModel> tests = [];
  EcoTestModel currentTest;
  EcoTestQuestionModel currentQuestion;
  List<EcoTestAnswerModel> answers = [];

  @override
  Stream<EcoTestState> mapEventToState(
    EcoTestEvent event,
  ) async* {
    if (event is EcoTestGetAllTestEvent) {
      yield EcoTestInitializedState(
        tests: List.from(tests),
        currentTest: currentTest,
        currentQuestion: currentQuestion,
        isLoading: true,
      );
      try {
        var response = await _profileRepository.getAllTest();
        tests.clear();
        tests.addAll(response);
        yield EcoTestInitializedState(
          tests: List.from(tests),
          currentTest: currentTest,
          currentQuestion: currentQuestion,
        );
      } catch (e) {
        yield EcoTestInitializedState(
          tests: List.from(tests),
          currentTest: currentTest,
          currentQuestion: currentQuestion,
          error: e.toString(),
        );
      }
    }

    if (event is EcoTestGetQuestionByTestIdEvent) {
      yield EcoTestInitializedState(
        tests: List.from(tests),
        currentTest: currentTest,
        currentQuestion: currentQuestion,
        isLoading: true,
      );
      try {
        var response = await _profileRepository.getQuestionsByEcoTestModel(
          event.testId,
        );
        tests.map((item) {
          if (item.id == event.testId) {
            item.questions = response;
          }
        });
        yield EcoTestInitializedState(
          tests: List.from(tests),
          currentTest: currentTest,
          currentQuestion: currentQuestion,
        );
      } catch (e) {
        yield EcoTestInitializedState(
          tests: List.from(tests),
          currentTest: currentTest,
          currentQuestion: currentQuestion,
          error: e.toString(),
        );
      }
    }


    if (event is EcoTestAnswerToQuestionEvent) {
      /// проверка есть ли у нас вообще вопросы
      if (currentTest != null && currentTest.questions != null) {
        /// ищем вопросы на которые у нас не дан ответ,
        /// такая реализация что бы была возможность пропуска ответов
        currentTest.questions.map((item) {
          var question =
              answers.lastWhere((element) => element.questionId == item.id);
          if (question == null) {
            currentQuestion = item;
            return;
          }
        });
        /// если список ответов равен списку вопросов,
        /// то пора отправлять тест на проверку,
        if (currentTest.questions.length == answers.length) {
          yield EcoTestInitializedState(
            tests: List.from(tests),
            currentTest: currentTest,
            currentQuestion: currentQuestion,
            isLoading: true,
          );
          try {
            var response = await _profileRepository.sendAttempt(
              currentTest.id,
              answers,
            );

            yield EcoTestInitializedState(
              tests: List.from(tests),
              currentTest: currentTest,
              currentQuestion: currentQuestion,
              result: response,
            );
          } catch (e) {
            yield EcoTestInitializedState(
              tests: List.from(tests),
              currentTest: currentTest,
              currentQuestion: currentQuestion,
              error: e.toString(),
            );
          }
        } else {
          yield EcoTestInitializedState(
            tests: List.from(tests),
            currentTest: currentTest,
            currentQuestion: currentQuestion,
          );
        }
      }
    }
    /// Стартует первый тест
    if (event is EcoTestStartTestEvent) {
      yield EcoTestInitializedState(
        tests: List.from(tests),
        currentTest: currentTest,
        currentQuestion: currentQuestion,
        isLoading: true,
      );
      if (tests.isNotEmpty) {
        currentTest = tests[0];
      }
      yield EcoTestInitializedState(
        tests: List.from(tests),
        currentTest: currentTest,
        currentQuestion: currentQuestion,
      );
    }
  }
}
