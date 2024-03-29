import 'package:http/http.dart' as http;

enum RequestErrorCode {
  apiUnreachable,
  unknown,
  notEnoughMoney,
  productIsOver,
  noSuchUser,
  recoverCodeInvalid,
  userAlreadyExists
}

class RequestError extends Error {
  RequestErrorCode code;
  String description;
  http.Response response;

  RequestError(
      {this.description, this.response, this.code = RequestErrorCode.unknown});

  @override
  String toString() => "RequestError {descripiton: $description}";
}
