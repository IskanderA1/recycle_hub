part of 'eco_test_bloc.dart';

abstract class EcoTestState extends Equatable {

  @override
  List<Object> get props => [];
}

class EcoTestStateInitial extends EcoTestState {

  EcoTestStateInitial();

  @override
  List<Object> get props => [];
}

class EcoTestStateLoading extends EcoTestState {

  EcoTestStateLoading();

  @override
  List<Object> get props => [];
}

class EcoTestStateError extends EcoTestState {

  final Object error;

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
  final String selectedAnswer;

  EcoTestStateLoaded(
      {this.currentAttempt,
      this.test,
      this.currentQuestion,
      this.isLoading = false,
      this.selectedAnswer = ''});

  @override
  List<Object> get props => [
        this.currentAttempt,
        this.test,
        this.isLoading,
        this.currentQuestion,
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

class EcoTestStateAnswered extends EcoTestState {
  final Attempt currentAttempt;
  final Question currentQuestion;
  final TestItem test;
  final String selectedAnswer;
  final AnswerResult lastAnswerResult;

  EcoTestStateAnswered(
      {this.currentAttempt,
      this.test,
      this.currentQuestion,
      this.selectedAnswer = '',
      this.lastAnswerResult});

  EcoTestStateAnswered.fromLoaded(
      EcoTestStateLoaded loaded, AnswerResult result)
      : this.currentAttempt = loaded.currentAttempt,
        this.test = loaded.test,
        this.currentQuestion = loaded.currentQuestion,
        this.selectedAnswer = loaded.selectedAnswer,
        this.lastAnswerResult = result;

  @override
  List<Object> get props => [
        this.currentAttempt,
        this.test,
        this.currentQuestion,
        this.selectedAnswer,
        this.lastAnswerResult
      ];

  EcoTestStateAnswered copyWith(
      {Attempt currentAttempt,
      TestItem test,
      bool isLoading,
      Question question,
      String selectedAnswer,
      AnswerResult lastAnswerResult}) {
    return EcoTestStateAnswered(
        currentAttempt: currentAttempt ?? this.currentAttempt,
        test: test ?? this.test,
        currentQuestion: question ?? this.currentQuestion,
        selectedAnswer: selectedAnswer ?? this.selectedAnswer,
        lastAnswerResult: lastAnswerResult ?? this.lastAnswerResult);
  }
}

class EcoTestStateCompleted extends EcoTestState {
  final AnswerResult result;
  final int gotPoints;

  EcoTestStateCompleted({this.result, this.gotPoints});

  @override
  List<Object> get props => [];
}
