import 'package:get/get.dart';

class HorizontalScrollController extends GetxController {
  RxDouble scrollPosition = 0.0.obs;
  RxInt selectedIndex = 1.obs;

  void updateScroll(double newPosition) {
    scrollPosition.value = newPosition;
    selectedIndex.value = (newPosition / 220).round();
  }
}
