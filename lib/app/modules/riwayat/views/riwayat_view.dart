import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/riwayat_controller.dart';
import '../../../widgets/bottom_nav_bar.dart';

class RiwayatView extends GetView<RiwayatController> {
  @override
  final RiwayatController controller = Get.put(RiwayatController());
  RiwayatView({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case "Selesai":
        return Colors.green;
      case "Dalam Perjalanan":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Icon getStatusIcon(String status) {
    switch (status) {
      case "Selesai":
        return const Icon(Icons.check_circle, color: Colors.green);
      case "Dalam Perjalanan":
        return const Icon(Icons.directions_car, color: Colors.orange);
      default:
        return const Icon(Icons.info_outline, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40), 
        child: Material(
          color: Color(0xFFf9f9f9),
          elevation: 0,
          child: SafeArea(
            child: SizedBox(
              height: 40, 
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Riwayat Perjalanan',
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statistik Ringkas
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Statistik Perjalanan",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildStatItem("Total", controller.total),
                        buildStatItem("Selesai", controller.selesai),
                        buildStatItem(
                            "Dalam Perjalanan", controller.dalamPerjalanan),
                      ],
                    ),
                  ],
                ),
              ),

              // Filter
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    const Text("Filter Status: ",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: controller.selectedStatus.value,
                                items: ['Semua', 'Selesai', 'Dalam Perjalanan']
                                    .map((status) => DropdownMenuItem(
                                          value: status,
                                          child: Text(status),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.selectedStatus.value = value;
                                  }
                                },
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // List Perjalanan
              Expanded(
                child: Obx(() {
                  final trips = controller.filteredTrips;
                  if (trips.isEmpty) {
                    return const Center(child: Text("Tidak ada perjalanan."));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return Obx(() {
                        final isExpanded =
                            controller.expandedIndex.value == index;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: getStatusIcon(trip.status),
                                title: Text(
                                  trip.route,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(trip.tanggal),
                                trailing: Text(
                                  trip.status,
                                  style: TextStyle(
                                    color: getStatusColor(trip.status),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  if (isExpanded) {
                                    controller.expandedIndex.value = null;
                                  } else {
                                    controller.expandedIndex.value = index;
                                  }
                                },
                              ),
                              AnimatedCrossFade(
                                firstChild: Container(),
                                secondChild: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      infoRow(Icons.calendar_today,
                                          "Tanggal: ${trip.tanggal}"),
                                      const SizedBox(height: 6),
                                      infoRow(Icons.person,
                                          "Nama Supir: ${trip.namaSupir}"),
                                      const SizedBox(height: 6),
                                      infoRow(Icons.directions_bus,
                                          "Armada: ${trip.armada}"),
                                      const SizedBox(height: 6),
                                      infoRow(Icons.location_on,
                                          "Rute: ${trip.route}"),
                                      const SizedBox(height: 6),
                                      infoRow(
                                        Icons.access_time,
                                        "Kedatangan: ${trip.kedatangan ?? 'Belum tiba'}",
                                      ),
                                      const SizedBox(height: 6),
                                      infoRow(
                                        Icons.people,
                                        "Jumlah Penumpang Awal: ${trip.jumlahPenumpangAwal?.toString() ?? '-'}",
                                      ),
                                    ],
                                  ),
                                ),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),
                                firstCurve: Curves.easeInOut,
                                secondCurve: Curves.easeInOut,
                                sizeCurve: Curves.easeInOut,
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  );
                }),
              ),
            ],
          );
        }
      }),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offNamed('/beranda');
              break;
            case 1:
              Get.offNamed('/jadwal');
              break;
            case 2:
              Get.offNamed('/detection');
              break;
            case 3:
              break;
            case 4:
              Get.offNamed('/profil');
              break;
          }
        },
      ),
    );
  }

  Widget buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text("$value",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade700),
        const SizedBox(width: 8),
        Flexible(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
