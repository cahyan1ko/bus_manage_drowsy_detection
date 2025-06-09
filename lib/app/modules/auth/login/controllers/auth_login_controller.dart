import 'package:capstone_bus_manage/app/utils/storage_helper.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

import 'package:google_sign_in/google_sign_in.dart';
import '../../../../data/providers/api_services.dart';
import '../../../../../app/routes/app_pages.dart';

class AuthLoginController extends GetxController {
  // final box = GetStorage();

  var username = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
      StorageHelper.saveUser(
        token: user.token,
        email: user.user.email,
        username: user.user.username,
        userId: user.user.id,
        hasPassword: user.user.hasPassword ?? true,
      );

      isLoading.value = false;

      Get.snackbar('Login Berhasil', 'Selamat datang ${user.user.username}!');
      Get.offAllNamed(Routes.BERANDA);
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      print("Error during login: $e");
    }
  }

  void loginWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final account = await _googleSignIn.signIn();

      if (account != null) {
        final auth = await account.authentication;

        final idToken = auth.idToken;

        if (idToken != null) {
          isLoading.value = true;
          final user = await ApiServices.googleLogin(idToken);
          isLoading.value = false;

          // final prefs = await SharedPreferences.getInstance();
          // await prefs.setString('token', user.token);
          // await prefs.setString('email', user.user.email);
          // await prefs.setString('username', user.user.username);
          // await prefs.setString('user_id', user.user.id);

          StorageHelper.saveUser(
            token: user.token,
            email: user.user.email,
            username: user.user.username,
            userId: user.user.id,
            hasPassword: user.user.hasPassword ?? true,
          );

          if (user.user.hasPassword == false) {
            Get.offAllNamed(Routes.BERANDA,
                arguments: {'needSetPassword': true});
          } else {
            Get.snackbar(
                'Login Berhasil', 'Selamat datang ${user.user.username}!');
            Get.offAllNamed(Routes.BERANDA);
          }
        } else {
          Get.snackbar('Error', 'Gagal mendapatkan token dari Google');
        }
      } else {}
    } catch (e) {
      isLoading.value = false;
      print("Google login error: $e");
      Get.snackbar('Error', 'Gagal login dengan Google');
    }
  }
}
