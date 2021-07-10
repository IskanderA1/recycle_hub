import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class FilterResponse {
  final List<FilterType> filterModels;
  final String error;

  FilterResponse(this.filterModels, this.error);

  FilterResponse.fromJson(var json)
      : filterModels = json.map((element) => new FilterType.fromJson(element)),
        error = "";
  FilterResponse.withError(String errorValue)
      : filterModels = List(),
        error = errorValue;
}
