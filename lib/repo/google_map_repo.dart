import 'dart:convert';
import 'package:recycle_hub/model/map_models.dart/coord.dart';
import 'package:recycle_hub/model/map_models.dart/markers_collection.dart';
import 'package:recycle_hub/model/map_responses/markers_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GoogleMapRepo {
  static String mainUrl = "http://eco.loliallen.com";
  GoogleMapRepo();

  Future<MarkersCollectionResponse> loadMarkersFrom4Coords(
    Coords x1,
    Coords x2,
    Coords x3,
    Coords x4,
  ) async {
    try {
      print("Запрос отправлен");
      var response = await http.get("$mainUrl/api/rec_points", headers: {
        'coords':
            "[[${x1.lat}, ${x1.lng}],[${x2.lat}, ${x2.lng}],[${x3.lat}, ${x3.lng}],[${x4.lat}, ${x4.lng}]]"
      });
      var data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        return MarkersCollectionResponseOk(data);
      } else {
        return MarkerCollectionResponseWithError(err: "Список пуст");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MarkerCollectionResponseWithError(err: "Нет сети");
    }
  }
}
