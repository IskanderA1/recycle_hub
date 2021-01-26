import 'dart:convert';

import 'package:flutter/foundation.dart';

class AcceptType {
  String id;
  List<String> badWords;
  List<String> keyWords;
  String name;
  String varName;
  AcceptType({
    this.id,
    this.badWords,
    this.keyWords,
    this.name,
    this.varName,
  });

  AcceptType copyWith({
    String id,
    List<String> badWords,
    List<String> keyWords,
    String name,
    String varName,
  }) {
    return AcceptType(
      id: id ?? this.id,
      badWords: badWords ?? this.badWords,
      keyWords: keyWords ?? this.keyWords,
      name: name ?? this.name,
      varName: varName ?? this.varName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'bad_words': badWords,
      'key_words': keyWords,
      'name': name,
      'var_name': varName,
    };
  }

  factory AcceptType.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AcceptType(
      id: map['_id'],
      badWords: List<String>.from(map['badWords']),
      keyWords: List<String>.from(map['keyWords']),
      name: map['name'],
      varName: map['varName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AcceptType.fromJson(String source) =>
      AcceptType.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AcceptType(id: $id, badWords: $badWords, keyWords: $keyWords, name: $name, varName: $varName)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AcceptType &&
        o.id == id &&
        listEquals(o.badWords, badWords) &&
        listEquals(o.keyWords, keyWords) &&
        o.name == name &&
        o.varName == varName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        badWords.hashCode ^
        keyWords.hashCode ^
        name.hashCode ^
        varName.hashCode;
  }
}
