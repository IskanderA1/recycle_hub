part of 'eco_test_bloc.dart';

abstract class EcoTestState extends Equatable {
  EcoTestResult get result;

  List<EcoTestModel> get tests;

  EcoTestModel get currentTest;

  EcoTestQuestionModel get currentQuestion;

  bool get isLoading;

  String get error;

  const EcoTestState();
}

class EcoTestInitializedState extends EcoTestState {
  final EcoTestResult result;
  final List<EcoTestModel> tests;
  final EcoTestModel currentTest;
  final EcoTestQuestionModel currentQuestion;
  final bool isLoading;
  final String error;

  EcoTestInitializedState({
    @required this.tests,
    @required this.currentTest,
    @required this.currentQuestion,
    this.result,
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object> get props => [
        tests,
        result,
        currentTest,
        currentQuestion,
        isLoading,
        error,
      ];
}
