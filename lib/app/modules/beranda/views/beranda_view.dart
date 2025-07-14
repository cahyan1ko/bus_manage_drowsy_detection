import 'package:capstone_bus_manage/app/data/models/artikel_model.dart';
import 'package:capstone_bus_manage/app/data/providers/api_services.dart';
import 'package:capstone_bus_manage/app/modules/jadwal/controllers/jadwal_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final JadwalController controllerJadwal = Get.put(JadwalController());

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Center(child: Text('Home Page')),
    const Center(child: Text('Search Page')),
    const Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    // final bool needSetPassword = args['needSetPassword'] == true;

    int currentIndex = 0;
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     offset: const Offset(0, 2),
            //     blurRadius: 4,
            //   ),
            // ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/images/travion_ls.svg',
                    height: 24,
                  ),
                  Row(
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.notifications_none,
                      //       color: Colors.black),
                      //   onPressed: () {
                      //     print("Pindah ke informasi");
                      //     Get.toNamed(Routes.STREAMLIT_WEBVIEW);
                      //   },
                      // ),
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
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: ListView(
          children: [
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   margin: const EdgeInsets.only(top: 16),
            //   decoration: BoxDecoration(
            //     color: Colors.red[50],
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: const Row(
            //     children: [
            //       Icon(
            //         Icons.directions_bus_filled,
            //         color: Color(0xffe25353),
            //         size: 40,
            //       ),
            //       SizedBox(width: 16),
            //       Expanded(
            //         child: Text(
            //           'Selamat bertugas! Cek jadwal perjalananmu hari ini.',
            //           style: TextStyle(fontSize: 16),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.STREAMLIT_WEBVIEW);
              },
              borderRadius: BorderRadius.circular(15),
              child: Card(
                color: const Color(0xFFFFFFFF),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Ikon cloud di kiri
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFCCE4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.cloud_outlined,
                          color: Color(0xFF3B82F6),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Teks (judul & deskripsi)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Cek Cuaca Tujuan!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Klik untuk cek cuaca',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Ikon arrow di ujung kanan
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xFF000000),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Jadwal Hari Ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Obx(() {
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

              return Card(
                color: const Color(0xFFFFFFFF),
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
                      infoRow("Tujuan", "${rute.terminalTujuan}"),
                      infoRow("Jam Berangkat", rute.jam),
                      infoRow("Bus", rute.namaBus),
                      infoRow("Nopol", rute.nopol),
                      infoRow(
                          "Jumlah Penumpang", "${rute.jumlahPenumpang} Orang"),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 12),
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
                                                    'rute':
                                                        rute, // kirim data jika perlu
                                                  });
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFE25353),
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
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            const Text(
              'Tips n Triks untuk Pengemudi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<ArtikelModel>>(
              future: ApiServices.fetchArtikel(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Gagal memuat artikel');
                }

                final articles = snapshot.data!;
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final artikel = articles[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/tips-detail',
                              arguments: artikel.artikelId);
                        },
                        child: Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 12),
                          child: Card(
                            color: Colors.transparent, // buat transparan
                            elevation: 0, // hilangkan bayangan
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                      bottom: Radius.circular(12)),
                                  child: Image.network(
                                    artikel.gambar.trim(),
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    artikel.judul,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors
                                          .black, // pastikan warnanya kontras dengan background
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
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
          margin: const EdgeInsets.only(bottom: 16),
          color: const Color(0xFFffffff),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // <-- ganti dari start ke center
              children: [
                Icon(icon,
                    size: 36, color: const Color(0xFFE25353).withOpacity(0.6)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment
                        .center, // tambah ini supaya teks juga center vertikal di kolom
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
