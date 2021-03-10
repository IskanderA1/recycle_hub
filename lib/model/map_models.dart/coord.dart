import 'dart:convert';

import 'package:hive/hive.dart';
part 'coord.g.dart';
@HiveType(typeId: 6)
class Coords {
  @HiveField(0)
  double lat;
  @HiveField(1)
  double lng;
  Coords({
    this.lat,
    this.lng,
  });

  Coords copyWith({
    double lat,
    double lng,
  }) {
    return Coords(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Coords.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Coords(
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Coords.fromJson(String source) => Coords.fromMap(json.decode(source));

  @override
  String toString() => 'Coords(lat: $lat, lng: $lng)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Coords && o.lat == lat && o.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
