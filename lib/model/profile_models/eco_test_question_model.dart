// To parse this JSON data, do
//
//     final question = questionFromMap(jsonString);

import 'dart:convert';

class Question {
    Question({
        this.questionId,
        this.question,
        this.questionType,
        this.answersVariants,
        this.pointForAnswer,
        this.image,
    });

    String questionId;
    String question;
    String questionType;
    List<String> answersVariants;
    int pointForAnswer;
    String image;

    Question copyWith({
        String questionId,
        String question,
        String questionType,
        List<String> answersVariants,
        int pointForAnswer,
        String image,
    }) => 
        Question(
            questionId: questionId ?? this.questionId,
            question: question ?? this.question,
            questionType: questionType ?? this.questionType,
            answersVariants: answersVariants ?? this.answersVariants,
            pointForAnswer: pointForAnswer ?? this.pointForAnswer,
            image: image ?? this.image,
        );

    factory Question.fromJson(String str) => Question.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Question.fromMap(Map<String, dynamic> json) => Question(
        questionId: json["question_id"] == null ? null : json["question_id"],
        question: json["question"] == null ? null : json["question"],
        questionType: json["question_type"] == null ? null : json["question_type"],
        answersVariants: json["answers_variants"] == null ? null : List<String>.from(json["answers_variants"].map((x) => x)),
        pointForAnswer: json["point_for_answer"] == null ? null : json["point_for_answer"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toMap() => {
        "question_id": questionId == null ? null : questionId,
        "question": question == null ? null : question,
        "question_type": questionType == null ? null : questionType,
        "answers_variants": answersVariants == null ? null : List<dynamic>.from(answersVariants.map((x) => x)),
        "point_for_answer": pointForAnswer == null ? null : pointForAnswer,
        "image": image == null ? null : image,
    };
}
