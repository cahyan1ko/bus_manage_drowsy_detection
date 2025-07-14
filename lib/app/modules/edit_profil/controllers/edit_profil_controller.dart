import 'package:capstone_bus_manage/app/data/providers/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone_bus_manage/app/utils/storage_helper.dart';

class EditProfilController extends GetxController {
  final nomorHpController = TextEditingController();
  final alamatController = TextEditingController();

  var selectedEdit = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nomorHpController.text = StorageHelper.phone ?? '';
    alamatController.text = StorageHelper.address ?? '';
  }

  void resetSelection() {
    selectedEdit.value = '';
  }

  void savePhone() async {
    final success =
        await ApiServices.updateProfil(nomorHp: nomorHpController.text.trim());
    if (success) {
      Get.snackbar('Berhasil', 'Nomor HP berhasil diperbarui');
      resetSelection();
    } else {
      Get.snackbar('Gagal', 'Gagal memperbarui nomor HP');
    }
  }

  void saveAddress() async {
    final success =
        await ApiServices.updateProfil(alamat: alamatController.text.trim());
    if (success) {
      Get.snackbar('Berhasil', 'Alamat berhasil diperbarui');
      resetSelection();
    } else {
      Get.snackbar('Gagal', 'Gagal memperbarui alamat');
    }
  }

  @override
  void onClose() {
    nomorHpController.dispose();
    alamatController.dispose();
    super.onClose();
  }
}
