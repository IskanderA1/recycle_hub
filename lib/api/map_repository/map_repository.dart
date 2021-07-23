import 'dart:convert';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/model/api_error.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';

class MapRepository {
  Future<CustMarker> updateMarker(CustMarker updated) async {
    try {
      var response = await CommonRequest.makeRequest(
        '/api/rec_offer/${updated.id}',
        method: CommonRequestMethod.put,
        body: jsonEncode(updated.toJson()),
      );
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if (data != null) {
          return CustMarker.fromMap(data);
        } else {
          throw Exception("Данных нет");
        }
      } else if (response.statusCode == 400) {
        if (data['error'] != null) {
          throw ApiError(
            statusCode: 400,
            type: ApiErrorType.testUnavailable,
            errorDescription: data['error'],
          );
        }
        throw Exception(response.reasonPhrase);
      }
      throw Exception("Данных нет");
    } catch (error) {
      rethrow;
    }
  }
}
