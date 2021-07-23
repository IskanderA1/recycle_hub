part of 'marker_edit_cubit.dart';

class MarkerEditState extends Equatable {
  final bool isLoading;
  final bool isEditing;
  final bool isSuccess;
  final String error;

  MarkerEditState({
    this.isSuccess = false,
    this.isLoading = false,
    this.isEditing = false,
    this.error,
  });
  @override
  List<Object> get props => [isLoading, isSuccess, isEditing, error];
}
