import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/auth/login_screen.dart';

class ApiService extends GetxService {
  final String baseUrl = 'https://permah.net';
  final storage = const FlutterSecureStorage();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static const String username = 'username';
  static const String _tokenKey = 'auth_token';

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
    await prefs.setString('token', token);
    _token.value = token;
  }

  Future<List<dynamic>> _fetchMembersLocally() async {
    final cacheData = await APICacheManager().getCacheData("members");
    return json.decode(cacheData.syncData);
  }

  Future<List<dynamic>> fetchMembers({bool forceRefresh = false}) async {
    print('fetching ...');
    final url = Uri.parse('$baseUrl/wp-json/buddypress/v1/members');
    try {
      final isCacheExist =
          await APICacheManager().isAPICacheKeyExist("members");
      if (isCacheExist && !forceRefresh) {
        return await _fetchMembersLocally();
      } else {
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json'
        }).timeout(const Duration(seconds: 5));

        if (response.statusCode == 200) {
          List<dynamic> members = json.decode(response.body);
          APICacheDBModel cacheDBModel =
              APICacheDBModel(key: "members", syncData: response.body);
          await APICacheManager().addCacheData(cacheDBModel);
          await _saveMembersLocally(members);
          return members;
        } else {
          throw Exception('Failed to load members');
        }
      }
    } catch (e) {
      return await _fetchMembersLocally();
    }
  }

  Future<void> _saveMembersLocally(List<dynamic> members) async {
    for (var member in members) {
      String avatarUrl = 'https:' + member['avatar_urls']['full'];
      String imageName = 'member_${member['id']}.jpg';
      await _saveImageLocally(avatarUrl, imageName);
    }
  }

  Future<void> _saveImageLocally(String imageUrl, String imageName) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/$imageName';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(response.bodyBytes);
      }
    } catch (e) {
      throw Exception('Failed to save image locally: $e');
    }
  }

  Future<Image?> loadImageFromStorage(String imageName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/$imageName';
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        return Image.file(imageFile);
      }
    } catch (e) {
      print('Failed to load image from storage: $e');
    }
    return null;
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
      Get.to(const LoginScreen());
    }
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

  void _onConnectivityChanged(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      fetchMembers(forceRefresh: true);
    }
  }
}
