import 'package:capstone_bus_manage/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/profil_controller.dart';

import '../../../widgets/bottom_nav_bar.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                  onPressed: () {},
                  icon: const Icon(Icons.help_outline),
                ),
                const Expanded(
                  child: Text(
                    'Profil Saya',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit), // icon help
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: NetworkImage('https://i.pravatar.cc/300'),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.NOTIFIKASI);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xFFE25353),
                        ),
                        child: const Icon(
                          Icons.edit, // icon pensil
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() => Text(
                    controller.nama.value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )),

              Obx(() => Text(
                    controller.email.value,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),

              const SizedBox(height: 20),

              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 18, // bisa disesuaikan
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Terverifikasi",
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              // Detail profil lain pakai menu widget
              Obx(() => ProfileMenuWidget(
                    title: 'Nomor HP',
                    icon: Icons.phone,
                    subtitle: controller.nomorHp.value,
                    onPress: () {},
                  )),

              Obx(() => ProfileMenuWidget(
                    title: 'Alamat',
                    icon: Icons.home,
                    subtitle: controller.alamat.value,
                    onPress: () {},
                  )),

              const Divider(),
              const SizedBox(height: 10),

              // Menu lain (contoh)
              ProfileMenuWidget(
                title: 'Pengaturan',
                icon: Icons.settings,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: 'Informasi',
                icon: Icons.info,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: 'Keluar',
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
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
                              Lottie.asset('assets/animations/question.json',
                                  height: 150),
                              const SizedBox(height: 16),
                              const Text(
                                'Keluar?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Apakah kamu yakin ingin keluar?',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await controller.logout();
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFFF4F4F4),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                            color: Color(0xFFE25353)),
                                      ),
                                    ),
                                    child: const Text(
                                      'Tidak',
                                      style:
                                          TextStyle(color: Color(0xFFE25353)),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Get.offAllNamed(Routes.LOGIN);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFFE25353),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Keluar',
                                      style: TextStyle(color: Colors.white),
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 4,
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
              Get.offNamed('/riwayat');
              break;
            case 4:
              break;
          }
        },
      ),
    );
  }
}

// Widget menu profil reusable
class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final Color? textColor;
  final bool endIcon;
  final String? subtitle;

  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.textColor,
    this.endIcon = true,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorText = textColor ?? Colors.black;

    return ListTile(
      leading: Icon(icon, color: colorText),
      title: Text(title,
          style: TextStyle(color: colorText, fontWeight: FontWeight.w600)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: endIcon ? const Icon(Icons.arrow_forward_ios) : null,
      onTap: onPress,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    );
  }
}
