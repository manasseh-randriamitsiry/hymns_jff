import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/sortie/liste_sortie_screen.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs; // Observable variable to track the selected index

  final List<Widget> pages = [
    const ListeSortieScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
    Get.off(() => pages[index], preventDuplicates: false);
  }
}
