import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permah_flutter/screen/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetxService {
  final String baseUrl = 'https://permah.net';
  final storage = const FlutterSecureStorage();

  static const String username = 'username';
  static const String _tokenKey = 'auth_token';

  // Reactive variable for token
  final RxString _token = ''.obs;

  // Get token value
  String get token => _token.value;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  // Save token to shared preferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _token.value = token;
  }

  Future<List<dynamic>> fetchMembers() async {
    final url = Uri.parse('$baseUrl/wp-json/buddypress/v1/members');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json', // Optional: Set the content type
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load members');
    }
  }

  // Signup method [role: contributor]
  Future<void> signup(String username, String password, String email) async {
    final url = Uri.parse('$baseUrl/wp-json/custom/v1/register');

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
      // Inscription réussie, pas besoin de décoder la réponse
      return;
    } else {
      // Gestion des erreurs avec un message personnalisé
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

  // Login method
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/wp-json/jwt-auth/v1/token');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      await _saveToken(responseBody['token']);
      await storage.write(key: 'username', value: username);
      return responseBody;
    } else {
      throw Exception('Failed to log in');
    }
  }

  // Logout method
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
      Get.to(
        const LoginScreen(),
      );
    }
  }

  // Get protected data
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

  Future<void> saveToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _tokenKey);
  }

  Future<void> removeToken() async {
    await storage.delete(key: _tokenKey);
  }
}
