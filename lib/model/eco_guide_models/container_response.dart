import 'package:recycle_hub/model/eco_guide_models/container_model.dart';

class ContainerResponse {
  final List<ContainerModel> containers;
  final String error;

  ContainerResponse({this.containers, this.error});

  ContainerResponse.fromJson(List json)
      : containers =
  (json).map((i) => new ContainerModel.fromJson(i)).toList(),
        error = "";

  ContainerResponse.withError(String errorValue)
      : containers = List(),
        error = errorValue;
}
