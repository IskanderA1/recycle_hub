import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recycle_hub/model/map_models.dart/filter_model.dart';
import 'package:recycle_hub/model/map_responses/markers_response.dart';
import 'package:recycle_hub/api/google_map_repo.dart';

class MarkersCollectionBloc {
  GoogleMapRepo _repo = GoogleMapRepo();

  StreamController<MarkersCollectionResponse> _behaviorSubject =
      StreamController<MarkersCollectionResponse>.broadcast();

  MarkerCollectionResponseLoading defaultItem =
      MarkerCollectionResponseLoading();

  LatLng lastLatLng;
  double lastZoom;

  Stream<MarkersCollectionResponse> get stream => _behaviorSubject.stream;

  pickEvent(MarkersCollectionResponse type) {
    _behaviorSubject.sink.add(type);
  }

  loadMarkersFromLast() async {
    _behaviorSubject.sink.add(MarkerCollectionResponseLoading());
    _repo.loadMarkersFrom4Coords(lastLatLng, lastZoom).then((value) =>_behaviorSubject.sink.add(value));
  }

  loadMarkers(LatLng latLng, double zoom) async {
    lastLatLng = latLng;
    lastZoom = zoom;
    _behaviorSubject.sink.add(MarkerCollectionResponseLoading());
    _repo.loadMarkersFrom4Coords(latLng, zoom).then((value) =>_behaviorSubject.sink.add(value));
  }

  filterMarkers(MapFilterModel filter) async {
    //_behaviorSubject.sink.add(MarkerCollectionResponseLoading());
    _repo.getMarkersByFilter(filter).then((value) =>_behaviorSubject.sink.add(value));
  }

  dispose() {
    _behaviorSubject.close();
  }
}

MarkersCollectionBloc markersCollectionBloc = MarkersCollectionBloc();
