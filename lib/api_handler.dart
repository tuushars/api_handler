import 'package:dio/dio.dart';
import 'package:dio_api_handler/dio_api_handler.dart';

typedef RequestCall = Future<Response> Function();
typedef ResponseParser<T> = T Function(dynamic data);

class ApiHandler {
  static Future<ApiResult<T>> request<T>({
    required RequestCall request,
    required ResponseParser<T> response,
  }) async {
    try {
      final res = await request();
      final parsed = response(res.data);
      return ApiSuccess<T>(parsed, res.statusCode);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      if (DioApiHandler.config.onError != null) {
        DioApiHandler.config.onError!(e, null);
      }
      return ApiFailure("Unexpected error", errorDetails: e);
    }
  }

  static ApiFailure<T> _handleError<T>(DioException e) {
    final statusCode = e.response?.statusCode;

    final message = e.response?.data is Map
        ? e.response?.data["message"] ?? "Something went wrong"
        : e.message ?? "Something went wrong";

    if (DioApiHandler.config.onError != null) {
      DioApiHandler.config.onError!(e.response?.data, statusCode);
    }

    return ApiFailure<T>(message, statusCode: statusCode, errorDetails: e.response?.data);
  }
}