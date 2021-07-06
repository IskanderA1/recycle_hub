part of 'eco_test_bloc.dart';

abstract class EcoTestEvent extends Equatable {
  const EcoTestEvent();
}

/* /// получение всех тестов
class EcoTestGetAllTestEvent extends EcoTestEvent {
  @override
  List<Object> get props => [];
} */

/* /// получение вопросов по конкретному тесту
class EcoTestGetQuestionByTestIdEvent extends EcoTestEvent {
  final String testId;

  EcoTestGetQuestionByTestIdEvent(this.testId);
  @override
  List<Object> get props => [testId];
} */

/// Запуск теста. Ща стартует первый тест в сипск, потом можно
/// добавить поле тестId
class EcoTestStartTestEvent extends EcoTestEvent {
  EcoTestStartTestEvent();
  @override
  List<Object> get props => [];
}

class EcoTestEventReset extends EcoTestEvent {
  EcoTestEventReset();
  @override
  List<Object> get props => [];
}

/// Добавление ответа на вопрос теста
class EcoTestAnswerToQuestionEvent extends EcoTestEvent {

  EcoTestAnswerToQuestionEvent();
  @override
  List<Object> get props => [];
}

/// Добавление ответа на вопрос теста
class EcoTestEventNextQuestion extends EcoTestEvent {
  EcoTestEventNextQuestion();
  @override
  List<Object> get props => [];
}

/// Добавление ответа на вопрос теста
class EcoTestEventSelectAnswer extends EcoTestEvent {
  final String answer;
  EcoTestEventSelectAnswer(this.answer);
  @override
  List<Object> get props => [];
}
