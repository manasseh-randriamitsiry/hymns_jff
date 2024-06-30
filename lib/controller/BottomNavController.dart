import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs; // Observable variable to track the selected index

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
