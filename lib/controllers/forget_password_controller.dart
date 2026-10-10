

import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {

  RxBool loading = false.obs;

  void setLoading (bool value) {
    loading.value = value;
  }
}