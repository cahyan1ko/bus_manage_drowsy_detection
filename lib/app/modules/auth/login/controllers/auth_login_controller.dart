import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/routes/app_pages.dart';

class AuthLoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  void login() {
    isLoading.value = true;
    Future.delayed(Duration(seconds: 1), () {
      isLoading.value = false;
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Color(0xfff4f4f4),
          duration: Duration(seconds: 2),
          borderRadius: 8,
          margin: EdgeInsets.all(12),
          snackPosition: SnackPosition.TOP,
          animationDuration: Duration(milliseconds: 500),
          icon: Icon(Icons.check_circle, color: Colors.black),
          shouldIconPulse: true,
          titleText: Text(
            'Selamat datang!',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            'Semoga harimu menyenangkan :)',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
      Get.offAllNamed(Routes.BERANDA);
    });
  }
}
