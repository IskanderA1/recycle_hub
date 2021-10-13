import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:recycle_hub/api/request/api_error.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/model/api_error.dart';

enum CommonRequestMethod { get, post, put, delete }

enum CommonRequestEncoding { json, url }

class CommonRequest {
  static const String devURL = "https://recyclehub.ru:5000/api";
  static const String prodURL = "https://recyclehub.ru:5000/api";

  static const String apiURL = prodURL;
  static http.Client get defaultClient => IOClient(HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true)
    ..connectionTimeout = Duration(seconds: 60)
    ..findProxy = HttpClient.findProxyFromEnvironment);

  static Future<http.Response> makeRequest(String endpoint,
      {CommonRequestMethod method = CommonRequestMethod.get,
      Map<String, dynamic> params,
      dynamic body,
      bool needAuthorization = true,
      String baseURL = apiURL}) async {
    Map<String, String> headers = {};

    if ([CommonRequestMethod.post, CommonRequestMethod.put].contains(method)) {
      headers["content-type"] = "application/json";
    }

    if (needAuthorization) {
      bool isNeedLogin = await SessionManager().isNeedLogin();
      if (isNeedLogin && endpoint != "authentication") {
        await SessionManager().relogin();
      }
      String authToken = await SessionManager().getAuthorizationToken();

      developer.log("Auth Token: $authToken", name: 'recycle.api.request');

      if (authToken == null) {
        await SessionManager().initializeApi();
        authToken = await SessionManager().getAuthorizationToken();
      }

      headers['Authorization'] = "Bearer $authToken";
    }

    bool isAvailableNetwork = await NetworkHelper.checkNetwork();
    if (!isAvailableNetwork) {
      throw RequestError(
          code: RequestErrorCode.apiUnreachable,
          description: "Server unreachable",
          response: null);
    }

    switch (method) {
      case CommonRequestMethod.get:
        return _getRequest(baseURL, endpoint, body, headers);
      case CommonRequestMethod.post:
        return _postRequest(baseURL, endpoint, params, body, headers);
      case CommonRequestMethod.delete:
        return _deleteRequest(baseURL, endpoint, body, headers);
      case CommonRequestMethod.put:
        return _putRequest(baseURL, endpoint, params, body, headers);
      default:
        return http.post(Uri(path: apiURL + endpoint), headers: headers);
    }
  }

  static String buildQueryString(Map<String, dynamic> params) {
    String queryString = params.entries.map((MapEntry<String, dynamic> entry) {
      String param = "${entry.key}=${entry.value}";
      return param;
    }).join("&");

    return "?$queryString";
  }

  // MARK: - request

  static Future<http.Response> _getRequest(String baseURL, String endpoint,
      Map<String, dynamic> body, Map<String, String> headers) async {
    String url = '$baseURL/$endpoint';
    if (body != null) {
      String params = buildQueryString(body);
      url = '$endpoint/$params';
    }
    developer.log("GET: $url", name: 'recycle.api.request');

    var response;
    try {
      response = await defaultClient.get(
          Uri.https('167.172.105.146:5000', '/api/$endpoint', body),
          headers: headers);
    } on http.ClientException catch (e) {
      throw ApiError(
          type: ApiErrorType.descriptionError, errorDescription: e.message);
    } on HandshakeException catch (e) {
      throw ApiError(
          type: ApiErrorType.descriptionError, errorDescription: e.message);
    } catch (e) {
      throw e;
    }

    return response;
  }

  static Future<http.Response> _postRequest(
      String baseURL,
      String endpoint,
      Map<String, dynamic> params,
      dynamic body,
      Map<String, String> headers) async {
    String url = baseURL + '/' + endpoint;
    if (params != null) {
      String queryParams = buildQueryString(params);
      endpoint = endpoint + queryParams;
    }
    String jsonBody = jsonEncode(body);
    developer.log("POST: $url", name: 'recycle.api.request');
    developer.log("JSONBODY: $jsonBody", name: 'recycle.api.request');
    developer.log("BODY: $body", name: 'recycle.api.request');

    var response;
    try {
      response = await defaultClient.post(Uri.parse(url),
          headers: headers, body: jsonBody);
    } on http.ClientException catch (e) {
      throw ApiError(
          type: ApiErrorType.descriptionError, errorDescription: e.message);
    } on HandshakeException catch (e) {
      throw ApiError(
          type: ApiErrorType.descriptionError, errorDescription: e.message);
    } catch (e) {
      developer.log("Error on: ${e.toString()}", name: 'recycle.api.request');
      throw e;
    }

    return response;
  }

  static Future<http.Response> _deleteRequest(String baseURL, String endpoint,
      dynamic body, Map<String, String> headers) async {
    if (body != null) {
      String params = buildQueryString(body);
      endpoint = endpoint + params;
    }
    String url = '$baseURL/$endpoint';
    developer.log("DELETE: $url", name: 'recycle.api.request');

    var response;
    try {
      response = await defaultClient.delete(Uri.parse(url), headers: headers);
    } on http.ClientException catch (e) {
      throw ApiError(
          type: ApiErrorType.descriptionError, errorDescription: e.message);
    } on HandshakeException catch (e) {
      throw ApiError(
          type: ApiErrorType.descriptionError, errorDescription: e.message);
    } catch (e) {
      throw e;
    }

    return response;
  }

  static Future<http.Response> _putRequest(
      String baseURL,
      String endpoint,
      Map<String, dynamic> params,
      dynamic body,
      Map<String, dynamic> headers) async {
    String url = '$baseURL/$endpoint';

    if (params != null) {
      String urlParams = buildQueryString(params);
      url = baseURL + endpoint + urlParams;
    }
    developer.log("PUT: $url", name: 'recycle.api.request');

    var response;
    try {
      if (body != null) {
        //String jsonBody = jsonEncode(body);

        response = await defaultClient.put(Uri.parse(url),
            headers: headers, body: body);
      } else {
        response =
            await defaultClient.put(Uri(path: baseURL + url), headers: headers);
      }
    } on http.ClientException catch (e) {
      throw ApiError(
          type: ApiErrorType.descriptionError, errorDescription: e.message);
    } on HandshakeException catch (e) {
      throw ApiError(
          type: ApiErrorType.descriptionError, errorDescription: e.message);
    } catch (e) {
      throw e;
    }

    return response;
  }
}
