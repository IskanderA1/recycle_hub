import 'package:bloc/bloc.dart';
import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class FilterTypeCubit extends Cubit<List<FilterType>> {
  FilterTypeCubit() : super([]);

  loadFilterTypes() async {
    try {
      final list = await PointsService().getAcceptTypes();
      emit(list);
    } catch (e) {
      print(e.toString());
      emit([]);
    }
  }
}
