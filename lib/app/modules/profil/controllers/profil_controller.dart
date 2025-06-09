import 'package:capstone_bus_manage/app/routes/app_pages.dart';
import 'package:capstone_bus_manage/app/utils/storage_helper.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ProfilController extends GetxController {
  var nama = ''.obs;
  var email = ''.obs;
  var nomorHp = ''.obs;
  var alamat = ''.obs;
  var needSetPassword = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  void loadUserProfile() {
    nama.value = StorageHelper.username ?? 'John Doe';
    email.value = StorageHelper.email ?? 'john.doe@example.com';
    nomorHp.value = '081234567890'; // hardcoded sementara
    alamat.value = 'Jl. Merdeka No. 123, Jakarta'; // hardcoded sementara

    print('DEBUG: hasPassword = ${StorageHelper.hasPassword}');
    needSetPassword.value = !StorageHelper.hasPassword;

    print('DEBUG: needSetPassword = ${needSetPassword.value}');
  }

  Future<void> logout() async {
    try {
      print('DEBUG: logout() dipanggil');
      if (await _googleSignIn.isSignedIn()) {
        print('DEBUG: user signed in via Google, signOut dipanggil');
        await _googleSignIn.signOut();
      }
      print('DEBUG: sebelum StorageHelper.clear()');
      await StorageHelper.clear();
      print('DEBUG: setelah StorageHelper.clear()');
      Get.offAllNamed(Routes.LOGIN); 
    } catch (e) {
      print('Logout error: $e');
      Get.snackbar('Logout Gagal', 'Terjadi kesalahan saat logout.');
    }
  }
}
