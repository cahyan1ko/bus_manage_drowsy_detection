import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/settings_history_devices_controller.dart';

class SettingsHistoryDevicesView
    extends GetView<SettingsHistoryDevicesController> {
  const SettingsHistoryDevicesView({super.key});

  String formatDate(String utcDate) {
    final date = DateTime.parse(utcDate).toLocal();
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Material(
          color: const Color(0xFFf9f9f9),
          elevation: 0,
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Expanded(
                  child: Text(
                    'Riwayat Perangkat',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  width: 48, // Sama dengan lebar IconButton
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.devices.isEmpty) {
          return const Center(
              child: Text("Belum ada perangkat yang pernah login."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.devices.length,
          itemBuilder: (context, index) {
            final item = controller.devices[index];

            return Card(
              color: const Color(0xFFFFFFFF), // <-- Warna putih
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(
                  Icons.devices_other_rounded,
                  size: 36,
                  color: Colors.blueAccent,
                ),
                title: Text(
                  item['device_name'] ?? 'Perangkat Tidak Diketahui',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(item['device_os'] ?? 'OS tidak dikenal'),
                trailing: Text(
                  item['login_time'] != null
                      ? formatDate(item['login_time'])
                      : 'Waktu tidak tersedia',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
