part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState({this.markers});

  final List<CustMarker> markers;

  @override
  List<Object> get props => [markers];
}

class MapStateInitial extends MapState {
  @override
  List<Object> get props => [];
}

class MapStateError extends MapState {
  final String discription;

  MapStateError({@required this.discription});

  @override
  List<Object> get props => [];
}

class MapStateLoading extends MapState {
  @override
  List<Object> get props => [];
}

class MapStateLoaded extends MapState {
  MapStateLoaded(List<CustMarker> markers) : super(markers: markers);
  @override
  List<Object> get props => [markers];
}
