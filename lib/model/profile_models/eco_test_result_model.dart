// To parse this JSON data, do
//
//     final answerResult = answerResultFromMap(jsonString);

import 'dart:convert';

class AnswerResult {
    AnswerResult({
        this.answerStatus,
        this.correctAnswer,
        this.yourAnswer,
        this.description,
        this.currentPoints,
        this.pointsToSuccess,
        this.isAttemptSuccess,
    });

    bool answerStatus;
    String correctAnswer;
    String yourAnswer;
    String description;
    int currentPoints;
    int pointsToSuccess;
    bool isAttemptSuccess;

    AnswerResult copyWith({
        bool answerStatus,
        String correctAnswer,
        String yourAnswer,
        String description,
        int currentPoints,
        int pointsToSuccess,
        bool isAttemptSuccess,
    }) => 
        AnswerResult(
            answerStatus: answerStatus ?? this.answerStatus,
            correctAnswer: correctAnswer ?? this.correctAnswer,
            yourAnswer: yourAnswer ?? this.yourAnswer,
            description: description ?? this.description,
            currentPoints: currentPoints ?? this.currentPoints,
            pointsToSuccess: pointsToSuccess ?? this.pointsToSuccess,
            isAttemptSuccess: isAttemptSuccess ?? this.isAttemptSuccess,
        );

    factory AnswerResult.fromJson(String str) => AnswerResult.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AnswerResult.fromMap(Map<String, dynamic> json) => AnswerResult(
        answerStatus: json["answer_status"] == null ? null : json["answer_status"],
        correctAnswer: json["correct_answer"] == null ? null : json["correct_answer"],
        yourAnswer: json["your_answer"] == null ? null : json["your_answer"],
        description: json["description"] == null ? null : json["description"],
        currentPoints: json["current_points"] == null ? null : json["current_points"],
        pointsToSuccess: json["points_to_success"] == null ? null : json["points_to_success"],
        isAttemptSuccess: json["is_attempt_success"] == null ? null : json["is_attempt_success"],
    );

    Map<String, dynamic> toMap() => {
        "answer_status": answerStatus == null ? null : answerStatus,
        "correct_answer": correctAnswer == null ? null : correctAnswer,
        "your_answer": yourAnswer == null ? null : yourAnswer,
        "description": description == null ? null : description,
        "current_points": currentPoints == null ? null : currentPoints,
        "points_to_success": pointsToSuccess == null ? null : pointsToSuccess,
        "is_attempt_success": isAttemptSuccess == null ? null : isAttemptSuccess,
    };
}
