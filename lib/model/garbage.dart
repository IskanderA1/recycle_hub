import 'package:flutter/foundation.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

class GarbageTupple {
  final FilterType filterType;
  final double ammount;

  GarbageTupple({@required this.filterType, @required this.ammount});

  Map<String, dynamic> toMap() => {
        "filter_type": filterType == null ? null : filterType.id,
        "amount": ammount == null ? null : ammount,
    };
}
