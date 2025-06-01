import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/bottom_nav_bar.dart';

class ProfilView extends StatelessWidget {
  // Contoh data statis
  final String nama = "John Doe";
  final String email = "john.doe@example.com";
  final String nomorHp = "081234567890";
  final String alamat = "Jl. Merdeka No. 123, Jakarta";

  const ProfilView({Key? key}) : super(key: key);

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
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(
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
                  onPressed: () {
                    // Aksi saat tombol help ditekan
                  },
                  icon: const Icon(Icons.help_outline), // icon help
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
                      child: Image(
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
                        // Aksi edit foto profil
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFE25353),
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
              Text(
                nama,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),

              // Tombol edit profil
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman edit profil (bisa pakai Get.to)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE25353),
                    shape: const StadiumBorder(),
                    side: BorderSide.none,
                  ),
                  child: const Text(
                    'Edit Profil',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              // Detail profil lain pakai menu widget
              ProfileMenuWidget(
                title: 'Nomor HP',
                icon: Icons.phone,
                subtitle: nomorHp,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: 'Alamat',
                icon: Icons.home,
                subtitle: alamat,
                onPress: () {},
              ),

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
                title: 'Logout',
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: "Logout",
                    content: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text("Apakah kamu yakin ingin keluar?"),
                    ),
                    confirm: ElevatedButton(
                      onPressed: () {
                        // Logout logic
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      child: const Text("Ya"),
                    ),
                    cancel: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("Tidak"),
                    ),
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
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.textColor,
    this.endIcon = true,
    this.subtitle,
  }) : super(key: key);

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
