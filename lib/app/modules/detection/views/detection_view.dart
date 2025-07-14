import 'package:camera/camera.dart';
import 'package:capstone_bus_manage/app/modules/jadwal/controllers/jadwal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/detection_controller.dart';
import '../../../widgets/bottom_nav_bar.dart';

class DetectionView extends GetView<DetectionController> {
  const DetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    // Auto start kamera jika diminta
    if (args != null &&
        args['autoStart'] == true &&
        !controller.isCameraInitialized.value) {
      controller.startCamera();
    }

    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Material(
          color: const Color(0xFFf9f9f9),
          elevation: 0,
          child: SafeArea(
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  'Perjalanan Anda',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final jadwal = controller.jadwal.value;

          // Jika tidak ada jadwal
          if (jadwal == null) {
            return const Center(
              child: Text(
                'Tidak ada jadwal perjalanan hari ini.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // Jika kamera belum aktif, tampilkan jadwal dan tombol start
          if (!controller.isCameraInitialized.value) {
            return _JadwalSection(jadwal: jadwal);
          }

          // Jika kamera aktif, tampilkan preview dan kontrol
          return _CameraSection();
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

class _JadwalSection extends StatelessWidget {
  final Map<String, dynamic> jadwal;

  _JadwalSection({required this.jadwal});
  final JadwalController controllerJadwal = Get.put(JadwalController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final rute = controllerJadwal.jadwalHariIni.value;

      if (rute == null) {
        return const Center(
          child: Text(
            'Tidak ada jadwal hari ini',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color(0xFFffffff),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoRow("Tujuan", rute.terminalTujuan ?? '-'),
                    infoRow("Jam Berangkat", rute.jam ?? '-'),
                    infoRow("Bus", rute.namaBus ?? '-'),
                    infoRow("Nopol", rute.nopol ?? '-'),
                    infoRow(
                        "Jumlah Penumpang", "${rute.jumlahPenumpang} Orang"),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: Get.context!,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: const Color(0xFFF4F4F4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                      'assets/animations/bus.json',
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Siap Berangkat?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Perjalanan akan segera dimulai. Tetap semangat dan hati-hati di jalan!',
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFF4F4F4),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                color: Color(0xFFE25353),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'Nanti',
                                            style: TextStyle(
                                                color: Color(0xFFE25353)),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Get.toNamed('/detection',
                                                arguments: {
                                                  'autoStart': true,
                                                  'rute': rute,
                                                });
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFE25353),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Mulai',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text(
                        "Konfirmasi dan Mulai Perjalanan!",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFE25353).withOpacity(0.6),
                        minimumSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _CameraSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetectionController>();

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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Obx(() => Text(
                        controller.predictedLabel.value != 'unknown'
                            ? 'Terdeteksi: ${controller.predictedLabel.value}'
                            : 'Mendeteksi wajah...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              ElevatedButton.icon(
                onPressed: controller.switchCamera,
                icon: const Icon(Icons.flip_camera_android),
                label: const Text('Switch'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
