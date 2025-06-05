import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilController extends GetxController {
  final box = GetStorage();

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
    nama.value = box.read('username') ?? 'John Doe';
    email.value = box.read('email') ?? 'john.doe@example.com';
    nomorHp.value = box.read('nomorHp') ?? '081234567890';
    alamat.value = box.read('alamat') ?? 'Jl. Merdeka No. 123, Jakarta';

    final hasPass = box.read('hasPassword');
    print('DEBUG: hasPassword dari box = $hasPass (${hasPass.runtimeType})');

    needSetPassword.value = hasPass is bool ? !hasPass : true;

    print('DEBUG: needSetPassword = ${needSetPassword.value}');
  }

  Future<void> logout() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      await box.erase();
      Get.offAllNamed('/login');
    } catch (e) {
      print('Logout error: $e');
    }
  }
}
