import 'package:equatable/equatable.dart';

/// модель вопроса
class EcoTestQuestionModel extends Equatable {
  String id;
  String test;
  String question;
  String questionType;
  List<String> answersVariants;
  String correctAnswer;
  int pointForAnswer;

  EcoTestQuestionModel(
      {this.id,
      this.test,
      this.question,
      this.questionType,
      this.answersVariants,
      this.correctAnswer,
      this.pointForAnswer});

  EcoTestQuestionModel.fromJson(dynamic json) {
    id = json["id"];
    test = json["test"];
    question = json["question"];
    questionType = json["question_type"];
    answersVariants = json["answers_variants"] != null
        ? json["answers_variants"].cast<String>()
        : [];
    correctAnswer = json["correct_answer"];
    pointForAnswer = json["point_for_answer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["test"] = test;
    map["question"] = question;
    map["question_type"] = questionType;
    map["answers_variants"] = answersVariants;
    map["correct_answer"] = correctAnswer;
    map["point_for_answer"] = pointForAnswer;
    return map;
  }

  @override
  List<Object> get props => [
        id,
        test,
        question,
        questionType,
        answersVariants,
        correctAnswer,
        pointForAnswer,
      ];
}
