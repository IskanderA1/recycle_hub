part of 'eco_test_bloc.dart';

abstract class EcoTestState extends Equatable {
  Attempt get attempt;

  @override
  List<Object> get props => [];
}

class EcoTestStateInitial extends EcoTestState {
  @override
  Attempt get attempt => null;

  EcoTestStateInitial();

  @override
  List<Object> get props => [];
}

class EcoTestStateLoading extends EcoTestState {
  @override
  Attempt get attempt => null;

  EcoTestStateLoading();

  @override
  List<Object> get props => [];
}

class EcoTestStateError extends EcoTestState {
  @override
  Attempt get attempt => null;

  Object error;

  EcoTestStateError(this.error);

  @override
  String toString() {
    return error.toString();
  }

  @override
  List<Object> get props => [];
}

class EcoTestStateLoaded extends EcoTestState {
  final Attempt currentAttempt;
  final Question currentQuestion;
  final TestItem test;
  final bool isLoading;
  final AnswerResult lastAnswerResult;
  final String selectedAnswer;

  EcoTestStateLoaded(
      {this.currentAttempt,
      this.test,
      this.currentQuestion,
      this.isLoading = false,
      this.lastAnswerResult,
      this.selectedAnswer = ''});

  @override
  Attempt get attempt => currentAttempt;

  @override
  List<Object> get props => [
        this.currentAttempt,
        this.test,
        this.isLoading,
        this.currentQuestion,
        this.lastAnswerResult,
        this.selectedAnswer
      ];

  EcoTestStateLoaded copyWith({
    Attempt currentAttempt,
    TestItem test,
    bool isLoading,
    Question question,
    String selectedAnswer,
  }) {
    return EcoTestStateLoaded(
        currentAttempt: currentAttempt ?? this.currentAttempt,
        test: test ?? this.test,
        isLoading: isLoading ?? this.isLoading,
        currentQuestion: question ?? this.currentQuestion,
        selectedAnswer: selectedAnswer ?? this.selectedAnswer);
  }
}

class EcoTestStateCompleted extends EcoTestState {
  AnswerResult result;
  int gotPoints;

  @override
  Attempt get attempt => null;

  EcoTestStateCompleted({this.result, this.gotPoints});

  @override
  List<Object> get props => [];
}
