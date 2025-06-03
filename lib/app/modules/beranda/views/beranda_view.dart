import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../controllers/beranda_controller.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:capstone_bus_manage/app/routes/app_pages.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  @override
  State<BerandaView> createState() => _BerandaViewState();
}

class _BerandaViewState extends State<BerandaView> {
  int _selectedIndex = 0;

  final BerandaController controller = Get.put(BerandaController());

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Search Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hey, Jane!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none,
                            color: Colors.black),
                        onPressed: () {
                          print("Pindah ke informasi");
                          Get.toNamed(Routes.INFORMASI);
                        },
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/profil');
                        },
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/300'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.directions_bus_filled,
                      color: Colors.red, size: 40),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Selamat bertugas! Cek jadwal perjalananmu hari ini.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Jadwal Hari Ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Obx(() {
              final jadwal = controller.jadwalHariIni;
              if (jadwal.isEmpty) {
                return Center(
                  child: Text(
                    'Tidak ada jadwal hari ini',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                );
              }
              return Card(
                color: Color(0xFFffffff),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoRow("Tujuan", jadwal['tujuan']),
                      infoRow("Jam Berangkat", jadwal['jam']),
                      infoRow("Bus", jadwal['bus']),
                      infoRow("Status", jadwal['status']),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Color(0xFFF4F4F4),
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
                                      Text(
                                        'Siap Berangkat?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
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
                                                  Color(0xFFF4F4F4),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                side: const BorderSide(
                                                    color: Color(0xFFE25353)),
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
                                                    'autoStart': true
                                                  });
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xFFE25353),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text(
                                              'Mulai',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
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
                      )
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            const Text(
              'Tips n Triks untuk Pengemudi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  tipsCard(
                    icon: Icons.local_cafe,
                    title: 'Minum Kopi atau Teh',
                    description:
                        'Minuman berkafein dapat membantu meningkatkan kewaspadaan saat berkendara.',
                  ),
                  tipsCard(
                    icon: Icons.air,
                    title: 'Pentingkan Sirkulasi Udara',
                    description:
                        'Jaga ventilasi kabin supaya tetap segar agar tidak mudah mengantuk.',
                  ),
                  tipsCard(
                    icon: Icons.access_time,
                    title: 'Istirahat Teratur',
                    description:
                        'Ambil waktu istirahat singkat untuk mengurangi kelelahan dan meningkatkan fokus.',
                  ),
                  tipsCard(
                    icon: Icons.directions_run,
                    title: 'Gerakkan Tubuh',
                    description:
                        'Lakukan peregangan ringan saat berhenti untuk mengurangi rasa lelah.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Get.offNamed('/jadwal');
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
      //   height: 0,
      //   width: 70,
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(35),
      //     child: FloatingDetectionButton(
      //       isActive: currentIndex == 4,
      //       onPressed: () {
      //         setState(() {
      //           currentIndex = 4;
      //         });
      //         Get.offNamed('/detection');
      //       },
      //     ),
      //   ),
      // ),
    );
  }

  Widget infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value ?? '-',
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget tipsCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/tips-detail', arguments: {
          'icon': icon,
          'title': title,
          'description': description,
        });
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 12),
        child: Card(
          color: Color(0xFFffffff),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 36, color: Colors.redAccent),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
