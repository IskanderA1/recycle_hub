import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class AcceptTypesCollection {
  List<AcceptType> acceptTypes;
  AcceptTypesCollection({
    this.acceptTypes,
  });

  AcceptTypesCollection copyWith({
    List<AcceptType> acceptTypes,
  }) {
    return AcceptTypesCollection(
      acceptTypes: acceptTypes ?? this.acceptTypes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'acceptTypes': acceptTypes?.map((x) => x?.toMap())?.toList(),
    };
  }

  AcceptTypesCollection.fromMap(List<dynamic> map)
      : this.acceptTypes = List<AcceptType>.from(
            map?.map((x) => AcceptType.fromMapForFilter(x)));

  String toJson() => json.encode(toMap());

  AcceptTypesCollection.fromJson(String source) {
    AcceptTypesCollection.fromMap(json.decode(source));
  }

  @override
  String toString() => 'AcceptTypesCollection(acceptTypes: $acceptTypes)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AcceptTypesCollection && listEquals(o.acceptTypes, acceptTypes);
  }

  @override
  int get hashCode => acceptTypes.hashCode;
}
