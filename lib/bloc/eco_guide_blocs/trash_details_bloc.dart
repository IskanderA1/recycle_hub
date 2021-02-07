
import 'package:recycle_hub/model/eco_guide_models/filter_response.dart';
import 'package:recycle_hub/repo/eco_quide_repo.dart';
import 'package:rxdart/rxdart.dart';

class TrashDetailsBloc {
  EcoGuideRepository _ecoGuideRepository = EcoGuideRepository();
  final BehaviorSubject<FilterResponse> _containerController =
      BehaviorSubject<FilterResponse>();

  getFilters() async{
    FilterResponse containerResponse = await _ecoGuideRepository.getFilters();
    _containerController.sink.add(containerResponse);
  }

  dispose() {
    _containerController.close();
  }

  BehaviorSubject<FilterResponse> get containerController => _containerController;
}

final trashDetailsBloc = TrashDetailsBloc();
