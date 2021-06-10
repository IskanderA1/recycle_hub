import 'package:equatable/equatable.dart';

/// ответ на вопрос
class EcoTestAnswerModel extends Equatable{
  String questionId;
  String answer;

  EcoTestAnswerModel({
      this.questionId, 
      this.answer});

  EcoTestAnswerModel.fromJson(dynamic json) {
    questionId = json["question_id"];
    answer = json["answer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["question_id"] = questionId;
    map["answer"] = answer;
    return map;
  }

  @override
  List<Object> get props => [questionId, answer];

}