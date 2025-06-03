import 'package:capstone_bus_manage/app/data/providers/api_services.dart';
import 'package:capstone_bus_manage/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthVerifyOtpController extends GetxController {
  var isLoading = false.obs;

  Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<void> verifyOtp(String otp) async {
    isLoading.value = true;

    final email = await getSavedEmail();

    print('DEBUG: otp=$otp, email=$email');

    if (email == null) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Email tidak ditemukan. Silakan daftar ulang.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (otp.isEmpty) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'OTP tidak boleh kosong.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final result = await ApiServices.verifyOtp(otp: otp, email: email);
    isLoading.value = false;

    if (result['status'] == 'success') {
      Get.snackbar(
        'Sukses',
        result['message'],
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_email');

      Get.toNamed(Routes.LOGIN);
    } else {
      Get.snackbar(
        'Gagal',
        result['message'],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
