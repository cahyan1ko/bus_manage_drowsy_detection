import 'package:get/get.dart';
import '../../../../../app/routes/app_pages.dart';

class AuthLoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  void login() {
    // Hilangkan semua validasi dan API call
    isLoading.value = true;
    Future.delayed(Duration(seconds: 1), () {
      isLoading.value = false;
      Get.snackbar('Login Berhasil', 'Selamat datang!');
      Get.offAllNamed(Routes.BERANDA); // Arahkan langsung ke BERANDA
    });
  }
}
