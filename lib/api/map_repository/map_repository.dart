import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/model/api_error.dart';

class MapRepository {
  Future<bool> updateMarker({
    @required String markerId,
    @required String reportText,
  }) async {
    Map<String, dynamic> body = {
      'text': '$reportText',
      'type': ['ошибка ПП'],
      'rec_point': markerId,
    };
    try {
      var response = await CommonRequest.makeRequest(
        'rec_comment',
        method: CommonRequestMethod.post,
        body: body,
      );
      print(response.body);

      var data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
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
