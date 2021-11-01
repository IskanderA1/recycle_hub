import 'package:bloc/bloc.dart';
import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class FilterTypeCubit extends Cubit<List<FilterType>> {
  FilterTypeCubit() : super([]);

  loadFilterTypes() async {
    try {
      emit([]);
      final list = await PointsService().loadAcceptTypes();
      emit(list);
    } catch (e) {
      print(e.toString());
      emit([]);
    }
  }

  inputChanged(String input) async {
    try {
      var list = await PointsService().loadAcceptTypes();
      List<FilterType> newlist;
      if (input != null && input.isNotEmpty && input != 'Показать все') {
        newlist = [];
        for (int i = 0; i < list.length; i++) {
          for (int k = 0; k < list[i].keyWords.length; k++) {
            if (list[i].keyWords[k].toLowerCase().contains(input.toLowerCase())) {
              newlist.add(list[i]);
            }
          }
        }
      } else {
        newlist = list;
      }
      emit(newlist);
    } catch (e) {
      print(e.toString());
      emit([]);
    }
  }
}
