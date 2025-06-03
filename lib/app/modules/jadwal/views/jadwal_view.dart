import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../controllers/jadwal_controller.dart';

class JadwalView extends GetView<JadwalController> {
  const JadwalView({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt selectedCardIndex = (-1).obs;
    int currentIndex = 0;

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xfff9f9f9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40), // Atur tinggi di sini
        child: Material(
          color: const Color(0xFFf9f9f9),
          elevation: 0,
          child: SafeArea(
            child: SizedBox(
              height: 40, // Penting: tambahkan height di child juga
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Jadwal',
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
        top: false,
        child: Container(
          color: Color(0xfff9f9f9),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Maret 2025',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(10, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      selectedCardIndex.value =
                                          selectedCardIndex.value == index
                                              ? -1
                                              : index;
                                    },
                                    child: Container(
                                      width: 82,
                                      height: 114,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/sampletujuan.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 8,
                                            bottom: 8,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                '${index + 1}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Center(
                              child: Container(
                                width: 350,
                                height: 0.5,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (selectedCardIndex.value != -1) ...[
                              const SizedBox(height: 8),
                              const Text(
                                'Detail Keberangkatan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Card(
                                color: Color(0xffffffff),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 140,
                                              child: Text('Nomor Plat')),
                                          Text(': AB 1234 CD'),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 140,
                                              child: Text('Nomor Bus')),
                                          Text(': 002'),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 140,
                                              child: Text('Status Bus')),
                                          Text(': Berangkat'),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 140,
                                              child: Text('Penumpang Awal')),
                                          Text(': 30'),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 140,
                                              child: Text('Jam Keberangkatan')),
                                          Text(': 10:30 AM'),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 140,
                                              child: Text('Pengemudi')),
                                          Text(': Budi Santoso'),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 140,
                                              child: Text('Catatan')),
                                          Expanded(
                                              child: Text(
                                                  ': Bus berjalan lancar')),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Get.toNamed('/detail-opr');
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE25353)
                                              .withOpacity(0.8),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              'Tegal - Jakarta',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'klik untuk detail',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: const Color(0xFFf9f9f9),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Terminal',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'Estimasi',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Tegal'),
                                                Text('10:30 AM'),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Pemalang'),
                                                Text('11:15 AM'),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Pekalongan'),
                                                Text('12:00 PM'),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Cirebon'),
                                                Text('1:45 PM'),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Bekasi'),
                                                Text('4:30 PM'),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Jakarta'),
                                                Text('5:15 PM'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 16),
      //   child: SizedBox(
      //     width: 150,
      //     height: 45,
      //     child: FloatingActionButton(
      //       onPressed: () {
      //         Get.toNamed('/detection');
      //       },
      //       backgroundColor: Colors.grey[900],
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: const Text(
      //         'Mulai Perjalanan!',
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 14,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      // ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: SizedBox(
      //   height: 70,
      //   width: 70,
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(35),
      //     child: FloatingDetectionButton(
      //       isActive: currentIndex == 4,
      //       onPressed: () {
      //         controller.currentIndex.value = 4;
      //         Get.offNamed('/detection');
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
