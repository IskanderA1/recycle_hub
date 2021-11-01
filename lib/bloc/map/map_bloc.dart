import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/bloc/filter_type_cubit.dart';
import 'package:recycle_hub/bloc/garb_collection_type_bloc.dart';
import 'package:recycle_hub/bloc/marker_work_mode_bloc.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types_collection_model.dart';
import 'package:recycle_hub/model/map_models.dart/filter_model.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'dart:developer' as developer;

import 'package:recycle_hub/screens/tabs/map/widgets/filter_card_widget.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapStateInitial());

  GarbageCollectionTypeBloc garbageCollBloc = GarbageCollectionTypeBloc();
  MarkerWorkModeBloc markerWorkModeBloc = MarkerWorkModeBloc();

  static final PointsService mapService = PointsService();
  final Location location = Location.instance;
  MapFilterModel currentFilterModel = MapFilterModel();
  FilterTypesCollection filterTypesCollection;

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    developer.log("Got ${event.runtimeType}", name: 'map.map_bloc');
    if (event is MapEventInit) {
      yield* _mapInitToState();
    } else if (event is MapEventFilter) {
      yield* _mapFilterToState(event);
    } else if (event is MapEventReset) {
      yield* _mapResetToState();
    }
  }

  Stream<MapState> _mapInitToState() async* {
    LocationData locationData;
    LatLng point;
    try {
      locationData = await location.getLocation().timeout(Duration(seconds: 30));
      point = LatLng(locationData.latitude, locationData.longitude);
    } catch (e) {
      point = LatLng(55.796127, 49.106414);
    }
    final list = await PointsService().loadAcceptTypes();
    filterTypesCollection = FilterTypesCollection.fromFilterTypes(list);
    var markers;
    try {
      markers = await mapService.loadMarkersFrom4Coords(point);
      yield MapStateLoaded(markers);
    } catch (e) {
      developer.log(e.toString(), name: 'map.map_bloc');
      yield MapStateLoaded(List<CustMarker>.empty());
    }
  }

  Stream<MapState> _mapFilterToState(MapEventFilter event) async* {
    try {
      var markers = await mapService.getMarkersByFilter(event.filter);
      yield MapStateLoaded(markers);
    } catch (e) {
      yield MapStateError(discription: '${e.toString()}');
    }
  }

  Stream<MapState> _mapResetToState() async* {
    garbageCollBloc.pickEvent(GCOLLTYPE.unknown);
    markerWorkModeBloc.pickEvent(MODE.unknown);
    currentFilterModel.filters = [];
    LocationData locationData;
    LatLng point;
    try {
      locationData = await location.getLocation().timeout(Duration(seconds: 30));
      point = LatLng(locationData.latitude, locationData.longitude);
    } catch (e) {
      point = LatLng(55.796127, 49.106414);
    }
    final list = await PointsService().loadAcceptTypes();
    filterTypesCollection = FilterTypesCollection.fromFilterTypes(list);
    var markers;
    try {
      markers = await mapService.loadMarkersFrom4Coords(point);
      yield MapStateLoaded(markers);
    } catch (e) {
      developer.log(e.toString(), name: 'map.map_bloc');
      yield MapStateLoaded(List<CustMarker>.empty());
    }
  }
}
