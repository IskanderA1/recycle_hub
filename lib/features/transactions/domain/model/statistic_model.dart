import 'package:flutter/foundation.dart';

class StatisticModel {
  double paperKG;
  double plasticKG;
  double glassKG;
  double othodyKG;
  double garbageKG;
  double othersKG;
  double totalKG;
  String errorMessage;
  double summ;
  StatisticModel(
      {@required this.paperKG,
      @required this.plasticKG,
      @required this.glassKG,
      @required this.othodyKG,
      @required this.garbageKG,
      @required this.othersKG,
      @required this.totalKG,
      @required this.errorMessage,
      @required this.summ});
}
