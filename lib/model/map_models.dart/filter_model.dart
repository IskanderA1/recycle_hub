import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapFilterModel {
  LatLng latLng;
  List<String> filters;
  String recType = "";
  String paybackType = "";

  MapFilterModel(
      {
        this.latLng,
      this.filters,
      this.recType,
      this.paybackType}){
        filters = List<String>.empty(growable: true);
      }
}
