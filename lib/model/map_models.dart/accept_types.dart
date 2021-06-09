// To parse this JSON data, do
//
//     final acceptType = acceptTypeFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'accept_types.g.dart';

@HiveType(typeId:2)
class FilterType {
  FilterType({
    this.id,
    this.name,
    this.varName,
    this.keyWords,
    this.badWords,
    this.coinsPerUnit,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String varName;
  @HiveField(3)
  List<String> keyWords;
  @HiveField(4)
  List<String> badWords;
  @HiveField(5)
  double coinsPerUnit;

  FilterType copyWith({
    String id,
    String name,
    String varName,
    List<String> keyWords,
    List<String> badWords,
    String coinsPerUnit,
  }) =>
      FilterType(
        id: id ?? this.id,
        name: name ?? this.name,
        varName: varName ?? this.varName,
        keyWords: keyWords ?? this.keyWords,
        badWords: badWords ?? this.badWords,
        coinsPerUnit: coinsPerUnit ?? this.coinsPerUnit,
      );

  factory FilterType.fromJson(String str) =>
      FilterType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilterType.fromMap(Map<String, dynamic> json) => FilterType(
        id: json["id"],
        name: json["name"],
        varName: json["var_name"],
        keyWords: List<String>.from(json["key_words"].map((x) => x)),
        badWords: List<String>.from(json["bad_words"].map((x) => x)),
        coinsPerUnit: json["coins_per_unit"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "var_name": varName,
        "key_words": List<dynamic>.from(keyWords.map((x) => x)),
        "bad_words": List<dynamic>.from(badWords.map((x) => x)),
        "coins_per_unit": coinsPerUnit,
      };
}
