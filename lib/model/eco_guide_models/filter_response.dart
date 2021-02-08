import 'package:recycle_hub/model/eco_guide_models/filter_model.dart';

class FilterResponse {
  final List<FilterModel> filterModels;
  final String error;

  FilterResponse(this.filterModels, this.error);

  FilterResponse.fromJson(var json)
      : filterModels = json.map((element) => new FilterModel.fromJson(element)),
        error = "";
  FilterResponse.withError(String errorValue)
      : filterModels = List(),
        error = errorValue;
}
