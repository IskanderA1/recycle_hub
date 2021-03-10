import 'package:recycle_hub/model/map_models.dart/coord.dart';
import 'package:recycle_hub/model/map_models.dart/filter_model.dart';
import 'package:recycle_hub/model/map_models.dart/markers_collection.dart';
import 'package:recycle_hub/model/map_responses/markers_response.dart';
import 'package:recycle_hub/repo/google_map_repo.dart';
import 'package:rxdart/rxdart.dart';

class MarkersCollectionBloc {
  GoogleMapRepo _repo = GoogleMapRepo();
  BehaviorSubject<MarkersCollectionResponse> _behaviorSubject =
      BehaviorSubject<MarkersCollectionResponse>();

  MarkerCollectionResponseLoading defaultItem =
      MarkerCollectionResponseLoading();

  Stream<MarkersCollectionResponse> get stream => _behaviorSubject.stream;

  MarkersCollectionResponse collection;

  pickEvent(MarkersCollectionResponse type) {
    _behaviorSubject.sink.add(type);
  }

  Future<MarkersCollectionResponse> loadMarkers() async {
    _behaviorSubject.sink.add(MarkerCollectionResponseLoading());
    MarkersCollectionResponse _response = await _repo.loadMarkersFrom4Coords(
        Coords(lat: 33, lng: 33),
        Coords(lat: 60, lng: 33),
        Coords(lat: 60, lng: 60),
        Coords(lat: 33, lng: 60));
    _behaviorSubject.sink.add(_response);
    collection = _response;
    return _response;
  }

  filterMarkers(MapFilterModel filter) async {
    //_behaviorSubject.sink.add(MarkerCollectionResponseLoading());
    MarkersCollectionResponse _response =
        await _repo.getMarkersByFilter(filter);
    _behaviorSubject.sink.add(_response);
    collection = _response;
  }

  dispose() {
    _behaviorSubject.close();
  }
}

MarkersCollectionBloc markersCollectionBloc = MarkersCollectionBloc();
