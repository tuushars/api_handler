import 'package:dio_result_handler/dio_result_handler.dart';
import 'package:flutter/material.dart';

void main() {
  DioApiHandler.init(
    config: DioApiHandlerConfig(
      baseUrl: () => "https://jsonplaceholder.typicode.com",
      token: () => null, // Optional
      onError: (dynamic error, int? statusCode) {
        debugPrint("Show Error pop up or message");
      },
    ),
  );
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// Creates the root [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Handler Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

/// The home page that fetches and displays users from the API.
class MyHomePage extends StatefulWidget {
  /// Creates a [MyHomePage] widget.
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  /// Fetches the list of users from the API and updates the state.
  Future<void> fetchUsers() async {
    final res = await callApi();
    switch (res) {
      case ApiSuccess():
        users = res.data;
        break;
      case ApiFailure():
        error = res.message;
        debugPrint(res.errorDetails);
    }
    setState(() {});
  }

  /// Holds the error message if the API call fails.
  String? error;

  /// The list of [User] objects returned from the API.
  List<User> users = [];

  /// Calls the API and returns an [ApiResult] containing a list of [User].
  Future<ApiResult<List<User>>> callApi() {
    return ApiHandler.request(
      request: () => ApiClient.dio.get("/users"),
      response: (data) =>
          (data as List<dynamic>).map((e) => User.fromJson(e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("API Handler"),
      ),
      body: Builder(builder: (context) {
        if (error != null) {
          return Center(child: Text(error!));
        }
        if (users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(child: Text("Total Users: ${users.length}"));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        tooltip: 'Fetch API',
        child: const Icon(Icons.http),
      ),
    );
  }
}

/// Represents a user returned from the API.
class User {
  /// The unique identifier of the user.
  int? id;

  /// The full name of the user.
  String? name;

  /// The username of the user.
  String? username;

  /// The email address of the user.
  String? email;

  /// The address of the user.
  Address? address;

  /// The phone number of the user.
  String? phone;

  /// The website of the user.
  String? website;

  /// The company the user works for.
  Company? company;

  /// Creates a [User] with the given fields.
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  /// Creates a [User] from a JSON map.
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  /// Converts this [User] to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['phone'] = phone;
    data['website'] = website;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

/// Represents a physical address associated with a [User].
class Address {
  /// The street name of the address.
  String? street;

  /// The suite or apartment number.
  String? suite;

  /// The city of the address.
  String? city;

  /// The zip code of the address.
  String? zipcode;

  /// The geographic coordinates of the address.
  Geo? geo;

  /// Creates an [Address] with the given fields.
  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  /// Creates an [Address] from a JSON map.
  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
  }

  /// Converts this [Address] to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['zipcode'] = zipcode;
    if (geo != null) {
      data['geo'] = geo!.toJson();
    }
    return data;
  }
}

/// Represents geographic coordinates (latitude and longitude).
class Geo {
  /// The latitude coordinate.
  String? lat;

  /// The longitude coordinate.
  String? lng;

  /// Creates a [Geo] with the given coordinates.
  Geo({this.lat, this.lng});

  /// Creates a [Geo] from a JSON map.
  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  /// Converts this [Geo] to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

/// Represents the company a [User] works for.
class Company {
  /// The name of the company.
  String? name;

  /// The company's catch phrase.
  String? catchPhrase;

  /// The company's business strategy summary.
  String? bs;

  /// Creates a [Company] with the given fields.
  Company({this.name, this.catchPhrase, this.bs});

  /// Creates a [Company] from a JSON map.
  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  /// Converts this [Company] to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;
    return data;
  }
}