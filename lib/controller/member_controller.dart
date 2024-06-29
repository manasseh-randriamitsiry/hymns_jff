import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_service.dart';

class MemberController extends GetxController {
  var members = <dynamic>[].obs;
  var isLoading = false.obs;

  final ApiService _apiService = Get.put(ApiService());

  @override
  void onInit() {
    super.onInit();
    fetchMembers();
  }

  void fetchMembers() async {
    try {
      isLoading(true);
      List<dynamic> fetchedMembers = await _apiService.fetchMembers();
      members.value = fetchedMembers;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar(
        'Erreur',
        'Verifier votre connection internet',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.white,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      );
    } finally {
      isLoading(false);
    }
  }
}
