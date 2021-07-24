import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:recycle_hub/api/map_repository/map_repository.dart';
import 'package:recycle_hub/model/api_error.dart';

part 'marker_edit_state.dart';

class MarkerEditCubit extends Cubit<MarkerEditState> {
  MarkerEditCubit() : super(MarkerEditState());
  final MapRepository _mapRepository = MapRepository();
  Future<void> updateMarker({
    @required String markerId,
    @required String reportText,
    @required String reportType,
  }) async {
    try {
      emit(MarkerEditState(isLoading: true));
      await _mapRepository.updateMarker(
        markerId: markerId,
        reportText: reportText,
        reportType: reportType,
      );
      emit(MarkerEditState());
    } catch (e) {
      if (e is ApiError) {
        emit(MarkerEditState(error: e.errorDescription));
      } else {
        emit(MarkerEditState(error: e.toString()));
      }
    }
  }
}
