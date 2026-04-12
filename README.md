# 🚀 Flutter Dio API Handler

A lightweight, clean, and scalable API handling layer built on top of Dio.
Designed for simplicity with powerful error handling using `ApiResult`.

---

## ✨ Features

* ✅ Simple API calling structure
* ✅ Built-in success & failure handling (`ApiResult`)
* ✅ Centralized error handling
* ✅ Clean and minimal architecture
* ✅ Easy to plug into any Flutter project
* ✅ Supports all HTTP methods (GET, POST, PUT, DELETE)

---

## 📦 Installation

Add dependency:

```yaml
dependencies:
  api_handler: 1.0.0
```

---

## ⚙️ Setup

Initialize the API client once (recommended in `main.dart`):

```dart
void main() {
  ApiClient.init(
    baseUrl: "https://api.example.com",
  );

  runApp(const MyApp());
}
```

---

## 🔑 Set Token (Optional)

```dart
ApiClient.setToken("your_access_token");
```

Remove token:

```dart
ApiClient.clearToken();
```

---

## 📡 Making API Calls

```dart
Future<ApiResult<Map<String, dynamic>>> getAllUsers() {
  return ApiHandler.request<Map<String, dynamic>>(
    request: () => ApiClient.dio.get("/users"),
    response: (data) => data,
  );
}
```

---

## 📊 Handling Response

```dart
final result = await getAllUsers();

if (result is ApiSuccess) {
  print(result.data);
} else if (result is ApiFailure) {
  print(result.message);
}
```

---

## 🧠 Custom Parsing

```dart
Future<ApiResult<List<User>>> getUsers() {
  return ApiHandler.request<List<User>>(
    request: () => ApiClient.dio.get("/users"),
    response: (data) =>
        (data as List).map((e) => User.fromJson(e)).toList(),
  );
}
```

---

## 🏗️ Structure

```
lib/
 ├── api_client.dart
 ├── api_handler.dart
 ├── api_result.dart
 └── exports.dart
```

---

## ❌ Error Handling

All errors are automatically wrapped into:

```dart
ApiFailure(
  message: String,
  errorDetails: dynamic
  statusCode: int?,
)
```

---

## 🔄 Available Methods

* GET
* POST
* PUT
* DELETE

(Handled via `ApiClient.dio`)

---

## 🔥 Best Practices

* Initialize `ApiClient` once
* Use `ApiHandler.request` for all API calls
* Avoid using Dio directly in UI
* Parse response inside `response` callback

---

## 🚀 Future Improvements

* Token refresh & retry mechanism
* Request logging toggle
* Global error mapper
* Pagination support

---

## 📄 License

MIT License
