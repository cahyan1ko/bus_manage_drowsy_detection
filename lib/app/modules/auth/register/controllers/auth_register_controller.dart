import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/providers/api_services.dart';
import '../../verify_otp/views/auth_verify_otp_view.dart';

class AuthRegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  void goToVerifyOtp() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field wajib diisi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPasswordController.text) {
      Get.snackbar('Error', 'Password dan Confirm Password tidak cocok',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final result = await ApiServices.register(
        username: username,
        email: email,
        password: password,
      );
      await saveEmail(email);

      isLoading.value = false;

      if (result['status'] == true || result['status'] == 'pending') {
        Get.snackbar(
          'Sukses',
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.to(() => VerifyOtpView());
      } else {
        Get.snackbar(
          'Gagal',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Terjadi Kesalahan',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
