import 'package:dio/dio.dart';
import 'dio_result_handler.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: DioApiHandler.config.baseUrl(),
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {

        final token = DioApiHandler.config.token?.call();
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }

        handler.next(options);
      },
    ),
  );
}