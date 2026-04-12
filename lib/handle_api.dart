import 'package:dio/dio.dart';
import 'api_result.dart';

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
      return ApiFailure("Unexpected error", errorDetails: e);
    }
  }

  static ApiFailure<T> _handleError<T>(DioException e) {
    final statusCode = e.response?.statusCode;

    final message = e.response?.data is Map
        ? e.response?.data["message"] ?? "Something went wrong"
        : e.message ?? "Something went wrong";

    return ApiFailure<T>(message, statusCode: statusCode);
  }
}