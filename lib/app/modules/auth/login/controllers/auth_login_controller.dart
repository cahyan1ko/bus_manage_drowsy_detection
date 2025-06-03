
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/providers/api_services.dart'; // sesuaikan pathnya
import '../../../../../app/routes/app_pages.dart';

class AuthLoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  void login() async {
    isLoading.value = true;
    errorMessage.value = '';

    if (username.value.isEmpty || password.value.isEmpty) {
      isLoading.value = false;
      errorMessage.value = 'Username dan password wajib diisi';
      return;
    }

    try {
      final user = await ApiServices.login(username.value, password.value);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', user.token);

      print('Token saved: ${prefs.getString('token')}');

      isLoading.value = false;
      Get.snackbar('Login Berhasil', 'Selamat datang!');
      Get.offAllNamed(Routes.BERANDA);
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      print("Error during login: $e"); // Cek pesan error di konsol
    }
  }
}
