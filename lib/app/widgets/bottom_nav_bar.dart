import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Material(
        elevation: 8,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFFe25353),
            unselectedItemColor: const Color(0xFF888888),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/non_active/Home.svg',
                  width: 20,
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/active/Home.svg',
                  width: 20,
                  height: 20,
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/non_active/Schedule.svg',
                  width: 20,
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/active/Schedule.svg',
                  width: 20,
                  height: 20,
                ),
                label: 'Jadwal',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/non_active/Profile.svg',
                  width: 20,
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/active/Profile.svg',
                  width: 20,
                  height: 20,
                ),
                label: 'Detection',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/non_active/History.svg',
                  width: 20,
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/active/History.svg',
                  width: 20,
                  height: 20,
                ),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/non_active/Profile.svg',
                  width: 20,
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/active/Profile.svg',
                  width: 20,
                  height: 20,
                ),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
