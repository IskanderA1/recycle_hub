import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/model/api_error.dart';

class MapRepository {
  Future<bool> updateMarker({
    @required String markerId,
    @required String reportText,
    @required String reportType,
  }) async {
    Map<String, dynamic> body = {
      'report_text': '$reportText',
      'report_type': '$reportType',
    };
    try {
      var response = await CommonRequest.makeRequest(
        '/api/rec_offer/$markerId',
        method: CommonRequestMethod.put,
        body: jsonEncode(body),
      );
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return true;
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
