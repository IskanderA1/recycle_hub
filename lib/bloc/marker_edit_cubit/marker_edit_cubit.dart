import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recycle_hub/api/map_repository/map_repository.dart';
import 'package:recycle_hub/model/api_error.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';

part 'marker_edit_state.dart';

class MarkerEditCubit extends Cubit<MarkerEditState> {
  MarkerEditCubit() : super(MarkerEditState());
  final MapRepository _mapRepository = MapRepository();
  Future<void> updateMarker(CustMarker updatedMarker) async {
    CustMarker marker;
    try {
      emit(MarkerEditState(isLoading: true));
      marker = await _mapRepository.updateMarker(marker);
      emit(MarkerEditState(isSuccess: true));
    } catch (e) {
      if (e is ApiError) {
        emit(MarkerEditState(isLoading: true, error: e.errorDescription));
      } else {
        emit(MarkerEditState(isLoading: true, error: e.toString()));
      }
    }
  }

  Future<void> editMarker(bool isEdit) async {
    emit(MarkerEditState(isEditing: isEdit));
  }
}
