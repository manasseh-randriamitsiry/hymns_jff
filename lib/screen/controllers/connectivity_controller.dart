import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/services/api_service.dart';

class ConnectivityController extends GetxController {
  var isConnected = false.obs;
  final ApiService apiService = ApiService();
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity(); // Initial check
    _startPeriodicCheck(); // Start periodic check
  }

  @override
  void onClose() {
    _timer.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }

  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      _reloadContent();
    }
  }

  void _startPeriodicCheck() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _checkConnectivity();
    });
  }

  void _reloadContent() {
    apiService.fetchMembers();
    // Logic to reload your content goes here
    // For example, you might call an API or refresh the app state
    print("Connected! Attempting to reload content...");
  }
}
