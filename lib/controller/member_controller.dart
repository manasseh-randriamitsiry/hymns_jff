import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/services/api_service.dart';

class MemberController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<dynamic> members = <dynamic>[].obs;
  final ApiService apiService = Get.put(ApiService());

  @override
  void onInit() {
    fetchMembers();
    super.onInit();
  }

  Future<void> fetchMembers() async {
    isLoading.value = true;
    try {
      List<dynamic> fetchedMembers = await apiService.fetchMembers();
      members.assignAll(fetchedMembers);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar(
        'Erreur',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.white,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<Image?> loadImageFromStorage(String imageName) {
    return apiService.loadImageFromStorage(imageName);
  }
}
