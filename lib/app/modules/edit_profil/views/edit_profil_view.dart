import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profil_controller.dart';

class EditProfilView extends GetView<EditProfilController> {
  const EditProfilView({super.key});
  static const baseColor = Color(0xFFE25353);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AppBar(
        title: const Text('Edit Profil'),
        centerTitle: true,
        backgroundColor: Color(0xfff9f9f9),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() {
          // Jika belum memilih
          if (controller.selectedEdit.value == '') {
            return Column(
              children: [
                const Text(
                  'Apa yang ingin kamu ubah?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.selectedEdit.value = 'hp';
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Edit Nomor HP'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor.withOpacity(0.6),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.selectedEdit.value = 'alamat';
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Edit Alamat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor.withOpacity(0.6),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
              ],
            );
          }

          // Jika memilih edit HP
          else if (controller.selectedEdit.value == 'hp') {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Nomor HP',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.nomorHpController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nomor HP baru',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.savePhone,
                        child: const Text('Simpan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor.withOpacity(0.6),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.resetSelection,
                        child: const Text('Kembali'),
                      ),
                    )
                  ],
                )
              ],
            );
          }

          // Jika memilih edit Alamat
          else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Alamat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.alamatController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Masukkan alamat baru',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.saveAddress,
                        child: const Text('Simpan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor.withOpacity(0.6),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.resetSelection,
                        child: const Text('Kembali'),
                      ),
                    )
                  ],
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
