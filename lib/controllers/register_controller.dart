

import 'package:get/get.dart';

class RegisterController extends GetxController {

  RxBool isPasswordVisible = false.obs;

  RxBool isConfirmPasswordVisible = false.obs;

  RxBool loading = false.obs;

  void togglePasswordVisibility () {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility () {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void setLoading (bool value) {
    loading.value = value;
  }
}