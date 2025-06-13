import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../controllers/jadwal_controller.dart';

class JadwalView extends GetView<JadwalController> {
  const JadwalView({super.key});

  String formatTanggal(String tanggal) {
    try {
      final DateTime parsedDate = DateTime.parse(tanggal);
      return DateFormat('d MMMM yyyy', 'id_ID').format(parsedDate);
    } catch (e) {
      return tanggal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final RxString selectedDate =
        ''.obs; // Untuk menyimpan tanggal yang dipilih

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xfff9f9f9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: SizedBox(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Jadwal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
        }

        if (controller.ruteList.isEmpty) {
          return const Center(child: Text('Belum ada jadwal'));
        }

        final today = DateTime.now();
        final uniqueDates = List.generate(7, (i) {
          final date = today.add(Duration(days: i));
          return DateFormat('yyyy-MM-dd').format(date);
        });

        if (selectedDate.value.isEmpty && uniqueDates.isNotEmpty) {
          selectedDate.value = uniqueDates.first;
        }

        final filteredList = controller.ruteList
            .where((r) => r.tanggal == selectedDate.value)
            .toList();

        return Column(
          children: [
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: uniqueDates.length,
                itemBuilder: (context, index) {
                  final date = uniqueDates[index];
                  final isSelected = selectedDate.value == date;

                  final tanggal = DateTime.parse(date);
                  final hari = DateFormat('EEEE', 'id_ID').format(tanggal);
                  final tgl = DateFormat('dd MMM', 'id_ID').format(tanggal);

                  return GestureDetector(
                    onTap: () => selectedDate.value = date,
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12, top: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xffe25353) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hari,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tgl,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredList.isEmpty
                  ? SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 80),
                          Lottie.asset(
                            'assets/animations/nothing.json',
                            width: 200,
                            height: 200,
                            repeat: false,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Tidak ada jadwal di tanggal ini',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final rute = filteredList[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          insetPadding:
                                              const EdgeInsets.all(16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Container(
                                            width: 300, // custom lebar
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color:
                                                            Color(0xffe25353)),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        '${rute.terminalAwal} → ${rute.terminalTujuan}',
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black87,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(height: 24),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .calendar_today_outlined,
                                                        size: 18,
                                                        color: Colors.grey),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                        'Tanggal: ${formatTanggal(rute.tanggal)}'),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .access_time_outlined,
                                                        size: 18,
                                                        color: Colors.grey),
                                                    const SizedBox(width: 6),
                                                    Text('Jam: ${rute.jam}'),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .directions_bus_filled,
                                                        size: 18,
                                                        color: Colors.grey),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                        'Bus: ${rute.namaBus}'),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.badge_outlined,
                                                        size: 18,
                                                        color: Colors.grey),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                        'Nopol: ${rute.nopol}'),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .people_alt_outlined,
                                                        size: 18,
                                                        color: Colors.grey),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                        'Penumpang: ${rute.jumlahPenumpang}'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          color: Color(0xffe25353)),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                rute.terminalAwal,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            const Icon(Icons.arrow_forward,
                                                size: 14,
                                                color: Colors.black87),
                                            const SizedBox(width: 6),
                                            Flexible(
                                              child: Text(
                                                rute.terminalTujuan,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Divider(thickness: 1, color: Colors.grey),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined,
                                        size: 18, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Tanggal: ${formatTanggal(rute.tanggal)}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_outlined,
                                        size: 18, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Jam: ${rute.jam}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.directions_bus_filled,
                                        size: 18, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Bus: ${rute.namaBus}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.badge_outlined,
                                        size: 18, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Nopol: ${rute.nopol}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.people_alt_outlined,
                                        size: 18, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Penumpang: ${rute.jumlahPenumpang}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offNamed('/beranda');
              break;
            case 1:
              break;
            case 2:
              Get.offNamed('/detection');
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
