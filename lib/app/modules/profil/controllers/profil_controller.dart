import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilController extends GetxController {
  final box = GetStorage();

  // Contoh data profil yang bisa diambil dari local storage atau API
  var nama = ''.obs;
  var email = ''.obs;
  var nomorHp = ''.obs;
  var alamat = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  void loadUserProfile() {
    // Ini hanya contoh, kamu bisa ganti dengan panggilan API atau GetStorage
    nama.value = box.read('nama') ?? 'John Doe';
    email.value = box.read('email') ?? 'john.doe@example.com';
    nomorHp.value = box.read('nomorHp') ?? '081234567890';
    alamat.value = box.read('alamat') ?? 'Jl. Merdeka No. 123, Jakarta';
  }

  Future<void> logout() async {
    // Hapus semua data dari local storage
    await box.erase();

    // Navigasi ke halaman login
    Get.offAllNamed('/login');
  }
}
