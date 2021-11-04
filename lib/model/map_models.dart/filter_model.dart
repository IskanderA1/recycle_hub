import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class MapFilterModel {
  LatLng latLng;
  List<FilterType> filters;

  MapFilterModel({
    this.latLng,
    this.filters,
  }) {
    filters = List<FilterType>.empty(growable: true);
  }
}
