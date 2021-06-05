part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapEventInit extends MapEvent {
  @override
  List<Object> get props => [];
}

class MapEventFilter extends MapEvent {
  final MapFilterModel filter;
  MapEventFilter({this.filter});
  @override
  List<Object> get props => [];
}
