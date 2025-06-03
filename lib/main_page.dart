import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone_bus_manage/app/widgets/bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Get.offNamed('/beranda');
        break;
      case 1:
        Get.offNamed('/jadwal');
        break;
      case 2:
        Get.offNamed('/profil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body disini kosong atau bisa diganti sesuai kebutuhan
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
