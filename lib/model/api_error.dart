
enum ApiErrorType {
  unknown,
  success,
  error,
  invalid,
  internalError,
  descriptionError
}

abstract class BaseError extends Error {
  ApiErrorType type;
  String errorDescription;
  int statusCode;
  BaseError({this.type, this.errorDescription = "", this.statusCode = 200});
}

class ApiError extends BaseError {
  ApiErrorType type;
  String errorDescription;
  int statusCode;
  ApiError({this.type, this.errorDescription = "", this.statusCode = 200});

  factory ApiError.fromJson(String message) {
    ApiErrorType type;

    switch (message) {
      case "Success":
        type = ApiErrorType.success;
        break;
      case "success":
        type = ApiErrorType.success;
        break;
      case "Error":
        type = ApiErrorType.error;
        break;
      case "INVALID":
        type = ApiErrorType.invalid;
        break;
      default:
        type = ApiErrorType.unknown;
        break;
    }

    return ApiError(type: type);
  }

  String toJson() {
    return "$type";
  }

  @override
  String toString() => "ApiError { type: $type }";
}
