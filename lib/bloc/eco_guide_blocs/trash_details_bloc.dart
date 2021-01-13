import 'package:recycle_hub/model/eco_guide_models/container_response.dart';
import 'package:recycle_hub/repo/eco_quide_repo.dart';
import 'package:rxdart/rxdart.dart';

class TrashDetailsBloc {
  EcoGuideRepository _ecoGuideRepository = EcoGuideRepository();
  final BehaviorSubject<ContainerResponse> _containerController =
      BehaviorSubject<ContainerResponse>();

  getContainers() {
    ContainerResponse containerResponse = _ecoGuideRepository.getContainers();
    _containerController.sink.add(containerResponse);
  }

  dispose() {
    _containerController.close();
  }

  BehaviorSubject<ContainerResponse> get containerController => _containerController;
}

final trashDetailsBloc = TrashDetailsBloc();
