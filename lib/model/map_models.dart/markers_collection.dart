import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:recycle_hub/model/map_models.dart/marker.dart';

class MarkersCollection {
  List<Marker> markers;
  MarkersCollection({
    this.markers,
  });

  MarkersCollection copyWith({
    List<Marker> markers,
  }) {
    return MarkersCollection(
      markers: markers ?? this.markers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'markers': markers?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory MarkersCollection.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MarkersCollection(
      markers: List<Marker>.from(map['markers']?.map((x) => Marker.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  MarkersCollection.fromJson(String source) {
    MarkersCollection.fromMap(json.decode(source));
  }

  @override
  String toString() => 'MarkersCollection(markers: $markers)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MarkersCollection && listEquals(o.markers, markers);
  }

  @override
  int get hashCode => markers.hashCode;
}
