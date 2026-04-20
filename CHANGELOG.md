## 1.0.2

* Just updated the example/main.dart and added comments for better understanding.

---

## 1.0.1

* Added support for `connectTimeout` and `receiveTimeout` in `DioApiHandlerConfig`.
* Improved configuration flexibility for network timeouts.

---

## 1.0.0

* Initial release with core API handling built on top of Dio.
* Added `ApiResult` with `ApiSuccess` and `ApiFailure` for clean response handling.
* Added `ApiHandler.request()` for unified GET, POST, PUT, and DELETE calls.
* Added `ApiClient` with token management (`setToken`, `clearToken`).
* Added `DioApiHandlerConfig` for centralized base URL, token, and error callback setup.