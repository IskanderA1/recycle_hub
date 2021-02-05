import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:recycle_hub/model/map_models.dart/feedbacker_model.dart';

class FeedBackerCollectionModel {
  List<FeedBackerModel> feedBacks;
  double rating;
  FeedBackerCollectionModel({
    this.feedBacks,
    this.rating,
  });

  FeedBackerCollectionModel copyWith({
    List<FeedBackerModel> feedBacks,
    double rating,
  }) {
    return FeedBackerCollectionModel(
      feedBacks: feedBacks ?? this.feedBacks,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'feedBacks': feedBacks?.map((x) => x?.toMap())?.toList(),
      'rating': rating,
    };
  }

  FeedBackerCollectionModel.fromMap(Map<String, dynamic> map)
      : this.feedBacks = List<FeedBackerModel>.from(
            map['feedBacks']?.map((x) => FeedBackerModel.fromMap(x))),
        rating = map['rating'];

  String toJson() => json.encode(toMap());

  factory FeedBackerCollectionModel.fromJson(source) =>
      FeedBackerCollectionModel.fromMap(/*json.decode(*/ source /*)*/);

  @override
  String toString() =>
      'FeedBackerCollectionModel(feedBacks: $feedBacks, rating: $rating)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FeedBackerCollectionModel &&
        listEquals(o.feedBacks, feedBacks) &&
        o.rating == rating;
  }

  @override
  int get hashCode => feedBacks.hashCode ^ rating.hashCode;
}
