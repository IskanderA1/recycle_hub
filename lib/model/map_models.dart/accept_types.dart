// To parse this JSON data, do
//
//     final acceptType = acceptTypeFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'accept_types.g.dart';

@HiveType(typeId: 2)
class FilterType extends Equatable {
  FilterType({
    this.id,
    this.name,
    this.varName,
    this.keyWords,
    this.badWords,
    this.coinsPerUnit,
    this.image,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String varName;
  @HiveField(3)
  final List<String> keyWords;
  @HiveField(4)
  final List<String> badWords;
  @HiveField(5)
  final double coinsPerUnit;
  @HiveField(6)
  final String image;

  FilterType copyWith({
    String id,
    String name,
    String varName,
    List<String> keyWords,
    List<String> badWords,
    int coinsPerUnit,
    String image,
  }) =>
      FilterType(
        id: id ?? this.id,
        name: name ?? this.name,
        varName: varName ?? this.varName,
        keyWords: keyWords ?? this.keyWords,
        badWords: badWords ?? this.badWords,
        coinsPerUnit: coinsPerUnit ?? this.coinsPerUnit,
        image: image ?? this.image,
      );

  factory FilterType.fromJson(String str) =>
      FilterType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilterType.fromMap(Map<String, dynamic> json) => FilterType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        varName: json["var_name"] == null ? null : json["var_name"],
        keyWords: json["key_words"] == null
            ? null
            : List<String>.from(json["key_words"].map((x) => x)),
        badWords: json["bad_words"] == null
            ? null
            : List<String>.from(json["bad_words"].map((x) => x)),
        coinsPerUnit:
            json["coins_per_unit"] == null ? null : json["coins_per_unit"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "var_name": varName == null ? null : varName,
        "key_words": keyWords == null
            ? null
            : List<dynamic>.from(keyWords.map((x) => x)),
        "bad_words": badWords == null
            ? null
            : List<dynamic>.from(badWords.map((x) => x)),
        "coins_per_unit": coinsPerUnit == null ? null : coinsPerUnit,
        "image": image == null ? null : image,
      };

  List<Object> get props => [
        this.id,
        this.badWords,
        this.coinsPerUnit,
        this.image,
        this.keyWords,
        this.name,
        this.varName
      ];
}
