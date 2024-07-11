import 'dart:async';
import 'dart:convert';

// import 'package:api_cache_manager/models/cache_db_model.dart';
// import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permah_flutter/screen/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetxService {
  final String baseUrl = 'https://www.permah.net';
  final storage = const FlutterSecureStorage();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static const String username = 'username';
  static const String _tokenKey = 'jwt_token';

  final RxString _token = ''.obs;

  String get token => _token.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getToken();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    _token.value = token;
  }

  Future<String?> getToken() async {
    String? savedToken = await storage.read(key: _tokenKey);
    if (savedToken != null && savedToken.isNotEmpty) {
      _token.value = savedToken;
      return savedToken;
    } else {
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
    _token.value = token;
  }

  Future<void> removeToken() async {
    await storage.delete(key: _tokenKey);
    _token.value = '';
  }

  Future<void> signup(String username, String password, String email) async {
    final url = Uri.parse('$baseUrl/wp-json/wp/v2/posts');

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      throw Exception('Verifier les champs');
    }
    final response = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "username": username,
            "email": email,
            "password": password,
          }),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 201) {
      return;
    } else {
      String message;
      try {
        final errorResponse = jsonDecode(response.body);
        message = errorResponse['message'] ?? 'Failed to sign up';
      } catch (e) {
        message = 'Failed to sign up: ${response.reasonPhrase}';
      }
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    const String loginEndpoint = "/wp-json/api/v1/token";
    final response = await http.post(
      Uri.parse("$baseUrl$loginEndpoint"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      await _saveToken(responseBody['jwt_token']);
      await storage.write(key: username, value: username);
      await storage.write(key: _tokenKey, value: responseBody['jwt_token']);
      await storage.write(
          key: 'expires_in', value: responseBody['expires_in'].toString());
      await storage.write(key: 'iat', value: responseBody['iat'].toString());
      return responseBody;
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<void> logout() async {
    if (_token.value.isNotEmpty) {
      final url = Uri.parse('$baseUrl/logout');
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': _token.value,
        },
      );
      await removeToken();
    }
    Get.off(() => const LoginScreen());
  }

  Future<Map<String, dynamic>> getProtectedData() async {
    if (_token.value.isEmpty) throw Exception('No token found');

    final url = Uri.parse('$baseUrl/protected');
    final response = await http.get(
      url,
      headers: {'Authorization': _token.value},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch protected data');
    }
  }

  Future<String?> getUsername() async {
    return await storage.read(key: username);
  }

  Future<String?> getExpirationDate() async {
    return await storage.read(key: 'expires_in');
  }

  Future<String?> geInitiatedDate() async {
    return await storage.read(key: 'iat');
  }

  void _onConnectivityChanged(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      // fetchMembers(forceRefresh: true);
    }
  }
}
