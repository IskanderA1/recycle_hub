// To parse this JSON data, do
//
//     final news = newsFromMap(jsonString);

import 'dart:convert';

class News {
    News({
        this.id,
        this.title,
        this.text,
        this.pubDate,
        this.isAdvice,
        this.image,
        this.isApproved,
    });

    String id;
    String title;
    String text;
    DateTime pubDate;
    bool isAdvice;
    String image;
    bool isApproved;

    News copyWith({
        String id,
        String title,
        String text,
        DateTime pubDate,
        bool isAdvice,
        String image,
        bool isApproved,
    }) => 
        News(
            id: id ?? this.id,
            title: title ?? this.title,
            text: text ?? this.text,
            pubDate: pubDate ?? this.pubDate,
            isAdvice: isAdvice ?? this.isAdvice,
            image: image ?? this.image,
            isApproved: isApproved ?? this.isApproved,
        );

    factory News.fromJson(String str) => News.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory News.fromMap(Map<String, dynamic> json) => News(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        pubDate: json["pub_date"] == null ? null : DateTime.parse(json["pub_date"]),
        isAdvice: json["is_advice"] == null ? null : json["is_advice"],
        image: json["image"] == null ? null : json["image"],
        isApproved: json["is_approved"] == null ? null : json["is_approved"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "text": text == null ? null : text,
        "pub_date": pubDate == null ? null : pubDate.toIso8601String(),
        "is_advice": isAdvice == null ? null : isAdvice,
        "image": image == null ? null : image,
        "is_approved": isApproved == null ? null : isApproved,
    };
}
