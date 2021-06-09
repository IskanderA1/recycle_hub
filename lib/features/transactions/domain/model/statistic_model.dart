import 'package:flutter/foundation.dart';

import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class StatisticModel {
  FilterType filterType;
  double count;
  StatisticModel({
    @required this.filterType,
    @required this.count,
  });
}
