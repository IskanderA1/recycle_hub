part of 'marker_edit_cubit.dart';

class MarkerEditState extends Equatable {
  final bool isLoading;
  final String error;

  MarkerEditState({
    this.isLoading = false,
    this.error,
  });
  @override
  List<Object> get props => [isLoading, error];
}
