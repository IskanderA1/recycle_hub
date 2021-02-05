import 'dart:convert';

class FeedBackerModel {
  String name;
  String surname;
  String feedBack;
  int hisFeedBacksCount;
  double hisFeedBack;
  int thumbsCount;
  String dateOfFeedBack;
  FeedBackerModel({
    this.name,
    this.surname,
    this.feedBack,
    this.hisFeedBacksCount,
    this.hisFeedBack,
    this.thumbsCount,
    this.dateOfFeedBack,
  });

  FeedBackerModel copyWith({
    String name,
    String surname,
    String feedBack,
    int hisFeedBacksCount,
    double hisFeedBack,
    int thumbsCount,
    String dateOfFeedBack,
  }) {
    return FeedBackerModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      feedBack: feedBack ?? this.feedBack,
      hisFeedBacksCount: hisFeedBacksCount ?? this.hisFeedBacksCount,
      hisFeedBack: hisFeedBack ?? this.hisFeedBack,
      thumbsCount: thumbsCount ?? this.thumbsCount,
      dateOfFeedBack: dateOfFeedBack ?? this.dateOfFeedBack,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'feedBack': feedBack,
      'hisFeedBacksCount': hisFeedBacksCount,
      'hisFeedBack': hisFeedBack,
      'thumbsCount': thumbsCount,
      'dateOfFeedBack': dateOfFeedBack,
    };
  }

  factory FeedBackerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FeedBackerModel(
      name: map['name'],
      surname: map['surname'],
      feedBack: map['feedBack'],
      hisFeedBacksCount: map['hisFeedBacksCount'],
      hisFeedBack: map['hisFeedBack'],
      thumbsCount: map['thumbsCount'],
      dateOfFeedBack: map['dateOfFeedBack'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedBackerModel.fromJson(String source) =>
      FeedBackerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeedBackerModel(name: $name, surname: $surname, feedBack: $feedBack, hisFeedBacksCount: $hisFeedBacksCount, hisFeedBack: $hisFeedBack, thumbsCount: $thumbsCount, dateOfFeedBack: $dateOfFeedBack)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FeedBackerModel &&
        o.name == name &&
        o.surname == surname &&
        o.feedBack == feedBack &&
        o.hisFeedBacksCount == hisFeedBacksCount &&
        o.hisFeedBack == hisFeedBack &&
        o.thumbsCount == thumbsCount &&
        o.dateOfFeedBack == dateOfFeedBack;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surname.hashCode ^
        feedBack.hashCode ^
        hisFeedBacksCount.hashCode ^
        hisFeedBack.hashCode ^
        thumbsCount.hashCode ^
        dateOfFeedBack.hashCode;
  }
}
