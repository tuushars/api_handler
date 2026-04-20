class DioApiHandlerConfig {
  final String Function() baseUrl;
  final String? Function()? token;
  final Duration? connectTimeout;
  final Duration? receiveTimeout;
  final void Function(dynamic error, int? statusCode)? onError;

  DioApiHandlerConfig({
    required this.baseUrl,
    this.token,
    this.connectTimeout,
    this.receiveTimeout,
    this.onError,
  });
}

class DioApiHandler {
  DioApiHandler._internal(this._config);

  final DioApiHandlerConfig _config;

  static DioApiHandler? _instance;

  static void init({required DioApiHandlerConfig config}) {
    _instance = DioApiHandler._internal(config);
  }

  static DioApiHandlerConfig get config {
    if (_instance == null) {
      throw Exception(
        "DioApiHandler not initialized. Call DioApiHandler.init() in main.dart",
      );
    }
    return _instance!._config;
  }
}