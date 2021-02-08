import 'package:recycle_hub/model/map_models.dart/coord.dart';

class FilterModel {
  Coords coordLeftTop = Coords(lat: 33, lng: 33);
  Coords coordRightTop = Coords(lat: 60, lng: 33);
  Coords coordRightButton = Coords(lat: 60, lng: 60);
  Coords coordLeftButton = Coords(lat: 33, lng: 60);
  List<String> filters = List<String>();
  String recType = "";
  String paybackType = "";

  FilterModel(
      {this.coordLeftTop,
      this.coordRightButton,
      this.filters,
      this.recType,
      this.paybackType}) {
    coordLeftTop = Coords(lat: 33, lng: 33);
    coordRightTop = Coords(lat: 60, lng: 33);
    coordRightButton = Coords(lat: 60, lng: 60);
    coordLeftButton = Coords(lat: 33, lng: 60);
    filters = List<String>();
    recType = "charity";
    paybackType = "paid";
  }
}
