import 'dart:convert';
import 'dart:async';
import 'package:recycle_hub/model/api_error.dart';

import 'api_error.dart';
import 'package:flutter/foundation.dart';
import 'package:recycle_hub/api/request/request.dart';


class GenericRequest<T> {
  String baseURL;
  CommonRequestMethod method;
  String endpoint;
  Map<String, dynamic> params;
  Map<String, dynamic> body;
  Map<String, dynamic> headers;
  bool needAuthorization;

  GenericRequest(
      {this.baseURL,
      this.method,
      this.endpoint,
      this.params,
      this.body,
      this.headers,
      this.needAuthorization = false});

  Future<T> send(T Function(dynamic json) creator) async {
    var response = await CommonRequest.makeRequest(
      endpoint,
      baseURL: baseURL ?? null,
      method: method,
      params: params,
      body: body,
      needAuthorization: needAuthorization,
    );
    if (response.statusCode < 200 || response.statusCode > 300) {
      throw ApiError(
          type: ApiErrorType.descriptionError,
          errorDescription: "Invalid response",
          statusCode: response.statusCode);
    }
    String responseData = response.body;
    dynamic json = await compute(decodeResponse, responseData);
    T model = creator(json);

    return model;
  }
}

dynamic decodeResponse(String response) {
  return jsonDecode(response);
}
