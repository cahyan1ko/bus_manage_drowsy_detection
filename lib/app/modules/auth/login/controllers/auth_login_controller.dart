import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../data/providers/api_services.dart';
import '../../../../../app/routes/app_pages.dart';

class AuthLoginController extends GetxController {
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

  void loginWithGoogle() async {
    try {
      await _googleSignIn.signOut(); // agar selalu memilih akun baru
      final account = await _googleSignIn.signIn();

      print("Google account: $account"); // debug: akun google yg dipilih

      if (account != null) {
        final auth = await account.authentication;

        print("Authentication info: $auth"); // debug: info autentikasi

        final idToken = auth.idToken;
        print("ID Token: $idToken"); // debug: token yang didapat

        if (idToken != null) {
          isLoading.value = true;
          final user = await ApiServices.googleLogin(idToken);
          isLoading.value = false;
          // TODO: handle user success
          print("Login with Google success: $user");
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', user.token);
          await prefs.setString('email', user.user.email);
          await prefs.setString('username', user.user.username);
          await prefs.setString('user_id', user.user.id);

          Get.snackbar(
              'Login Berhasil', 'Selamat datang ${user.user.username}!');
          Get.offAllNamed(Routes.BERANDA);
        } else {
          print("ID Token is null");
          Get.snackbar('Error', 'Gagal mendapatkan token dari Google');
        }
      } else {
        print("Google Sign-in canceled or no account selected");
        Get.snackbar('Error', 'Login Google dibatalkan');
      }
    } catch (e) {
      isLoading.value = false;
      print("Google login error: $e");
      Get.snackbar('Error', 'Gagal login dengan Google');
    }
  }
}
