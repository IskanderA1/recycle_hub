import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';

class MarkersCollection {
  @HiveField(0)
  final List<CustMarker> markers;
  final DateTime date;
  MarkersCollection({
    this.markers,
  }):date = DateTime.now();

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
            List<CustMarker>.from(map?.map((x) => CustMarker.fromMap(x))),
            date = DateTime.now();

  MarkersCollection.fromList(List list)
     :  this.markers = list,
        date = DateTime.now();

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
