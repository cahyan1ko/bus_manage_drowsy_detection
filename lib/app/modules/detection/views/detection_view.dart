import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detection_controller.dart';
import '../../../widgets/bottom_nav_bar.dart'; // Pastikan ini import ke widget BottomNavBar kamu

class DetectionView extends GetView<DetectionController> {
  const DetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    if (args != null &&
        args['autoStart'] == true &&
        !controller.isCameraInitialized.value) {
      controller.startCamera();
    }
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40), // Atur tinggi di sini
        child: Material(
          color: Color(0xFFf9f9f9),
          elevation: 0,
          child: SafeArea(
            child: SizedBox(
              height: 40, // Penting: tambahkan height di child juga
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Perjalanan Anda',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (!controller.isCameraInitialized.value) {
            return Center(
              child: ElevatedButton(
                onPressed: controller.startCamera,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Start Camera'),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CameraPreview(controller.cameraController!),
                    Positioned(
                      bottom: 24,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          controller.predictedLabel.value != 'unknown'
                              ? 'Detected: ${controller.predictedLabel.value}'
                              : 'Detecting face...',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: controller.stopCamera,
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: controller.switchCamera,
                      icon: const Icon(Icons.flip_camera_android),
                      label: const Text('Switch'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offNamed('/beranda');
              break;
            case 1:
              Get.offNamed('/jadwal');
              break;
            case 2:
              break;
            case 3:
              Get.offNamed('/riwayat');
              break;
            case 4:
              Get.offNamed('/profil');
              break;
          }
        },
      ),
    );
  }
}
