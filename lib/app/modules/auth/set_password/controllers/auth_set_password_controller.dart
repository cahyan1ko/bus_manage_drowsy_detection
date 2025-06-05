import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthSetPasswordController extends GetxController {
  var message = ''.obs;
  var isLoading = false.obs;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void setPassword() async {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Password dan konfirmasi password harus diisi');
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Password dan konfirmasi tidak sama');
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;
      Get.snackbar('Sukses', 'Password berhasil disimpan');
      Get.offAllNamed(
          '/beranda');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Gagal menyimpan password');
    }
  }
}
