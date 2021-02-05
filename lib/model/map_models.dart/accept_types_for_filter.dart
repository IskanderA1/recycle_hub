/*import 'dart:convert';

import 'package:flutter/foundation.dart';

class AcceptTypeForFilter {
  String id;
  List<String> badWords;
  List<String> keyWords;
  String name;
  String varName;
  AcceptTypeForFilter({
    this.id,
    this.badWords,
    this.keyWords,
    this.name,
    this.varName,
  });

  AcceptTypeForFilter copyWith({
    String id,
    List<String> badWords,
    List<String> keyWords,
    String name,
    String varName,
  }) {
    return AcceptTypeForFilter(
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

  AcceptTypeForFilter.fromMap(Map<String, dynamic> map) {
    if (map == null) return;

    id = map['_id']['! @ # \$ & * ~oid'];
    badWords = List<String>.from(map['bad_words']);
    keyWords = List<String>.from(map['key_words']);
    name = map['name'];
    varName = map['var_name'];
  }

  String toJson() => json.encode(toMap());

  AcceptTypeForFilter.fromJson(String source) {
    AcceptTypeForFilter.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'AcceptTypeForFolter(id: $id, badWords: $badWords, keyWords: $keyWords, name: $name, varName: $varName)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AcceptTypeForFilter &&
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
*/
