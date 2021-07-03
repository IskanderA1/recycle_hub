import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recycle_hub/api/profile_repository/profile_repository.dart';
import 'package:recycle_hub/model/api_error.dart';
import 'package:recycle_hub/model/profile_models/eco_test_answer_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_attempt_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_item_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_question_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_result_model.dart';

part 'eco_test_event.dart';

part 'eco_test_state.dart';

/// блок для работы с тестами
class EcoTestBloc extends Bloc<EcoTestEvent, EcoTestState> {
  final ProfileRepository _profileRepository;

  EcoTestBloc(this._profileRepository) : super(EcoTestStateInitial());

  TestItem currentTest;
  Attempt currentAttempt;
  List<EcoTestAnswerModel> answers = [];
  List<AnswerResult> answerResults = [];
  int currentAnswerInd = 0;

  @override
  Stream<EcoTestState> mapEventToState(
    EcoTestEvent event,
  ) async* {
    if (event is EcoTestStartTestEvent) {
      yield* _mapStartToState(event);
    } else if (event is EcoTestAnswerToQuestionEvent) {
      yield* _mapAnswerToState(event);
    } else if (event is EcoTestEventNextQuestion) {
      yield* _mapNextQuestionToState(event);
    } else if (event is EcoTestEventSelectAnswer) {
      yield* _mapSelectAnswerToState(event);
    }
  }

  Stream<EcoTestState> _mapStartToState(EcoTestStartTestEvent event) async* {
    yield EcoTestStateLoading();
    List<TestItem> tests;
    try {
      tests = await _profileRepository.getTests();
    } catch (e) {
      yield EcoTestStateError(e);
      return;
    }

    if (tests == null || tests.isEmpty) {
      yield EcoTestStateError('Список тестов пуст');
    }
    Attempt attempt;
    try {
      attempt = await _profileRepository.getAttempt(tests.first.id);
    } catch (e) {
      if (e is ApiError) {
        yield EcoTestStateError(e.errorDescription);
      } else {
        yield EcoTestStateError(e);
      }
      return;
    }
    currentAttempt = attempt;
    currentTest = tests.first;
    currentAnswerInd = 0;

    yield EcoTestStateLoaded(
        currentAttempt: currentAttempt,
        test: tests.first,
        currentQuestion: currentAttempt.questions.first);
  }

  Stream<EcoTestState> _mapAnswerToState(
      EcoTestAnswerToQuestionEvent event) async* {
    yield EcoTestStateLoading();
    if (currentAttempt == null || currentTest == null) {
      yield EcoTestStateError('Сперва следует создать попытку');
    }
    EcoTestState curState = state;
    if (curState is EcoTestStateLoaded) {
      yield curState.copyWith(isLoading: true);
    }
    AnswerResult result;
    try {
      result = await _profileRepository.sendAnswer(
          answer: event.answer,
          testId: currentAttempt.testId,
          attemptId: currentAttempt.id);
    } catch (e) {
      yield EcoTestStateError(e);
      return;
    }

    ///is completed
    ///TODO: CREATE EVENT TO CONTNUE THE TEST
    if (result.isAttemptSuccess != null) {
      yield EcoTestStateCompleted(
          result: result,
          gotPoints: result.isAttemptSuccess ? currentAttempt.points : 0);
    } else {
      try {
        yield EcoTestStateLoaded(
            currentAttempt: currentAttempt,
            test: currentTest,
            currentQuestion: currentAttempt.questions[currentAnswerInd],
            lastAnswerResult: result);
      } catch (e) {
        yield EcoTestStateError('Что-то пошло не так');
      }
    }
  }

  Stream<EcoTestState> _mapNextQuestionToState(
      EcoTestEventNextQuestion event) async* {
    currentAnswerInd++;
    yield EcoTestStateLoaded(
        currentAttempt: currentAttempt,
        test: currentTest,
        currentQuestion: currentAttempt.questions[currentAnswerInd]);
  }

  Stream<EcoTestState> _mapSelectAnswerToState(
      EcoTestEventSelectAnswer event) async* {
    EcoTestState cstate = state;
    if (cstate is EcoTestStateLoaded && event.answer != null) {
      yield cstate.copyWith(selectedAnswer: event.answer);
    }
  }
}
