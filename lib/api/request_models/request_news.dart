// To parse this JSON data, do
//
//     final requestNewsCreateModel = requestNewsCreateModelFromMap(jsonString);

import 'dart:convert';

class RequestNewsCreateModel {
    RequestNewsCreateModel({
        this.title,
        this.text,
        this.isAdvice,
    });

    String title;
    String text;
    bool isAdvice;

    RequestNewsCreateModel copyWith({
        String title,
        String text,
        bool isAdvice,
    }) => 
        RequestNewsCreateModel(
            title: title ?? this.title,
            text: text ?? this.text,
            isAdvice: isAdvice ?? this.isAdvice,
        );

    factory RequestNewsCreateModel.fromJson(String str) => RequestNewsCreateModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RequestNewsCreateModel.fromMap(Map<String, dynamic> json) => RequestNewsCreateModel(
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        isAdvice: json["is_advice"] == null ? null : json["is_advice"],
    );

    Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "text": text == null ? null : text,
        "is_advice": isAdvice == null ? null : isAdvice,
    };
}
