import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class FilterTypesCollection {
  List<FilterType> acceptTypes;
  List<String> acceptTypesStrings;
  FilterTypesCollection({
    this.acceptTypes,
    this.acceptTypesStrings,
  });

  factory FilterTypesCollection.fromFilterTypes(List<FilterType> acceptTypes) {
    final list = List<String>.from(acceptTypes.map((e) => e.name));
    return FilterTypesCollection(
        acceptTypes: acceptTypes, acceptTypesStrings: list);
  }

  List<String> getPatterns(String pattern) {
    List<String> patterns = List<String>();
    for (int i = 0; i < acceptTypes.length; i++) {
      for (int k = 0; k < acceptTypes[i].keyWords.length; k++) {
        if (acceptTypes[i]
            .keyWords[k]
            .toLowerCase()
            .contains(pattern.toLowerCase())) {
          patterns.add(acceptTypes[i].keyWords[k]);
        }
      }
    }
    return patterns;
  }

  String getVarNameByKeyWord(String pattern) {
    print("Выбирается");
    for (int i = 0; i < acceptTypes.length; i++) {
      for (int k = 0; k < acceptTypes[i].keyWords.length; k++) {
        if (acceptTypes[i].keyWords[k].toLowerCase() == pattern.toLowerCase()) {
          print("Выбрано");
          return acceptTypes[i].varName;
        }
      }
    }
  }

  FilterTypesCollection copyWith({
    List<FilterType> acceptTypes,
    List<String> acceptTypesStrings,
  }) {
    return FilterTypesCollection(
      acceptTypes: acceptTypes ?? this.acceptTypes,
      acceptTypesStrings: acceptTypesStrings ?? this.acceptTypesStrings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'acceptTypes': acceptTypes?.map((x) => x?.toMap())?.toList(),
      'acceptTypesStrings': acceptTypesStrings,
    };
  }

  FilterTypesCollection.fromMap(List<dynamic> map)
      : this.acceptTypes =
            List<FilterType>.from(map?.map((x) => FilterType.fromMap(x))),
        this.acceptTypesStrings = List<String>.from(map?.map((x) => "$x"));

  String toJson() => json.encode(toMap());

  factory FilterTypesCollection.fromJson(String source) =>
      FilterTypesCollection.fromMap(json.decode(source));

  @override
  String toString() =>
      'FilterTypesCollection(acceptTypes: $acceptTypes, acceptTypesStrings: $acceptTypesStrings)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FilterTypesCollection &&
        listEquals(o.acceptTypes, acceptTypes) &&
        listEquals(o.acceptTypesStrings, acceptTypesStrings);
  }

  @override
  int get hashCode => acceptTypes.hashCode ^ acceptTypesStrings.hashCode;
}
