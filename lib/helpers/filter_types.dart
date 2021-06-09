import 'dart:convert';

import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class FilterTypesService {
  static final FilterTypesService _inst = FilterTypesService._();

  FilterTypesService._();

  factory FilterTypesService() {
    return _inst;
  }

  List<FilterType> get filters {
    if (_filters == null) {
      _filters = List<FilterType>.empty(growable: true);
    }
    return _filters;
  }

  List<FilterType> _filters;

  Future<List<FilterType>> getFilters() async {
    if (_filters != null) {
      return _filters;
    }
    try {
      var response = await CommonRequest.makeRequest('filters');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _filters =
            List<FilterType>.from(data?.map((e) => FilterType.fromMap(e)));
        return _filters;
      } else {
        return [];
      }
    } catch (e) {
      print("Error loading filters: ${e.toString()}");
      return [];
    }
  }
}
