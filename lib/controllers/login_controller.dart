

import 'package:get/get.dart';

class LoginController extends GetxController {

  RxBool loading = false.obs;
  RxBool isPasswordVisible = false.obs;

  void togglePasswordVisible () {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void setLoading (bool value) {
    loading.value = value;
  }
}