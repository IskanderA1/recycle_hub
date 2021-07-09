import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class MapFilterModel {
  LatLng latLng;
  List<FilterType> filters;
  String recType = "";
  String paybackType = "";

  MapFilterModel({this.latLng, this.filters, this.recType, this.paybackType}) {
    filters = List<FilterType>.empty(growable: true);
  }
}
