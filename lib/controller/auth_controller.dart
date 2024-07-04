import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permah_flutter/screen/auth/interest_screen.dart';
import 'package:permah_flutter/screen/auth/login_screen.dart';

import '../screen/member/member_screen.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = ApiService();

  // Reactive variables
  var isAuthenticated = false.obs;
  var token = RxnString();
  final storage = const FlutterSecureStorage();

  Future<bool> checkInternetConnection() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('Internet connection check failed: $e');
    }
    return false;
  }

  // Signup method
  Future<void> signup(String username, String password, String confirmPassword,
      String email) async {
    bool isConnected = await checkInternetConnection();
    if (isConnected) {
      if (password != confirmPassword) {
        Get.snackbar(
          'Érreur mot de passe',
          'Raison : mot de passe different',
          backgroundColor: Colors.yellowAccent.withOpacity(0.2),
          colorText: Colors.black,
          icon: const Icon(Icons.warning_amber, color: Colors.black),
        );
      } else {
        try {
          await apiService.signup(username, password, email);
          Get.snackbar(
            'Success',
            'Inscription réussie pour $username',
            backgroundColor: Colors.green.withOpacity(0.2),
            colorText: Colors.black,
            icon: const Icon(Icons.check, color: Colors.black),
          );
          await apiService.login(username, password);

          Get.to(const InterestSelectionScreen());
        } catch (e) {
          // Affiche un snackbar d'erreur
          Get.snackbar(
            'Erreur de création de compte',
            'Raison : ${e.toString().replaceFirst('Exception: ', '')}',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: Colors.black,
            icon: const Icon(Icons.cancel, color: Colors.black),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
          );
          print(e);
        }
      }
    } else {
      Get.snackbar(
        'Internet error',
        'Salut $username, verifier votre connection',
        backgroundColor: Colors.green.withOpacity(0.2),
        colorText: Colors.black,
        icon: const Icon(Icons.signal_wifi_connected_no_internet_4),
      );
    }
  }

  // Login method
  Future<void> login(String username, String password) async {
    bool isConnected = await checkInternetConnection();
    if (isConnected) {
      try {
        final response = await apiService.login(username, password);
        token.value = response['token'];
        isAuthenticated.value = true;
        await storage.write(key: 'auth_token', value: token.value);
        Get.off(MembeScreen());
        Get.snackbar(
          'Success',
          'Hello $username',
          backgroundColor: Colors.green.withOpacity(0.2),
          colorText: Colors.black,
          icon: const Icon(Icons.check),
        );
      } catch (e) {
        Get.snackbar('Erreur connection', 'Verifier les informations',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: Colors.black,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(Icons.cancel),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeInOutCirc);
        print(e);
      }
    } else {
      Get.snackbar(
        'Internet error',
        'Salut $username, verifier votre connection',
        backgroundColor: Colors.green.withOpacity(0.2),
        colorText: Colors.black,
        icon: const Icon(Icons.signal_wifi_connected_no_internet_4),
      );
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await apiService.logout();
      isAuthenticated.value = false;
      apiService.removeToken();
      Get.snackbar(
        'Success',
        'Logout successful',
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      );
      Get.off(const LoginScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Logout failed: $e',
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      );
    }
  }
}
