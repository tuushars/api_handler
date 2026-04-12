sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  final int? statusCode;
  const ApiSuccess(this.data, this.statusCode);
}

class ApiFailure<T> extends ApiResult<T> {
  final String message;
  final dynamic errorDetails;
  final int? statusCode;
  const ApiFailure(this.message, {this.statusCode, this.errorDetails});
}