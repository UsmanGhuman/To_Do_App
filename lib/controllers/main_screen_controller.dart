import 'package:get/get.dart';

class MainScreenController extends GetxController {

  RxInt currentIndex = 0.obs;
  RxInt selectedNav = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index <= 2) {
      currentIndex.value = index;
      selectedNav.value = index;
    }
  }

  void setFocusTab() {
    selectedNav.value = 3;
  }

  void resetToHome() {
    currentIndex.value = 0;
    selectedNav.value = 0;
  }
}