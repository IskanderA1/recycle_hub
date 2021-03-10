import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';

class MarkersCollection {
  final List<CustMarker> markers;
  MarkersCollection({
    this.markers,
  });

  MarkersCollection copyWith({
    List<CustMarker> markers,
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

  MarkersCollection.fromMap(List map)
      : this.markers =
            List<CustMarker>.from(map?.map((x) => CustMarker.fromMap(x)));

  String toJson() => json.encode(toMap());

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
