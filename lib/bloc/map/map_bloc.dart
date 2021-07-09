import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/model/map_models.dart/filter_model.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'dart:developer' as developer;

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapStateInitial());

  static final PointsService mapService = PointsService();
  final Location location = Location.instance;

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    developer.log("Got ${event.runtimeType}", name: 'map.map_bloc');
    if (event is MapEventInit) {
      yield* _mapInitToState();
    }
    else if(event is MapEventFilter){
      yield* _mapFilterToState(event);
    }
  }

  Stream<MapState> _mapInitToState() async* {
    LocationData point;
    try {
      point = await location.getLocation();
    } catch (e) {
      point = null;
    }

    if (point == null) {
    } else {
      var markers;
      try {
        markers = await mapService.loadMarkersFrom4Coords(
            LatLng(point.latitude, point.longitude));
        yield MapStateLoaded(markers);
      } catch (e) {
        yield MapStateLoaded(List<CustMarker>.empty());
      }
    }
  }

  Stream<MapState> _mapFilterToState(MapEventFilter event) async* {
    
    try{
      var markers = await mapService.getMarkersByFilter(event.filter);
      yield MapStateLoaded(markers);
    }catch(e){
      yield MapStateError(discription: '${e.toString()}');
    }
  }
}
