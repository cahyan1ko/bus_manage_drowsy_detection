import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../routes/app_pages.dart';
import '../../utils/storage_helper.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    _buildPage(
      title: "Selamat Datang di Travion",
      description:
          "Travion adalah solusi cerdas untuk manajemen operasional bus dengan pemantauan perjalanan secara real-time.",
      lottiePath: "assets/animations/onboarding1.json",
    ),
    _buildPage(
      title: "Deteksi Kantuk Supir",
      description:
          "Fitur deteksi mengantuk membantu meningkatkan keselamatan perjalanan dengan memantau kondisi pengemudi.",
      lottiePath: "assets/animations/onboarding2.json",
    ),
    _buildPage(
      title: "Gabung Bersama Kami",
      description:
          "Mulai pengalaman baru dalam pengelolaan transportasi yang aman, cerdas, dan efisien bersama Travion.",
      lottiePath: "assets/animations/onboarding3.json",
    ),
  ];

  static Widget _buildPage({
    required String title,
    required String description,
    required String lottiePath,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          lottiePath,
          width: 300,
          repeat: true,
        ),
        const SizedBox(height: 30),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finishOnboarding() async {
    // await StorageHelper.setOnboardingSeen();
    if (StorageHelper.isLoggedIn) {
      Get.offAllNamed(Routes.BERANDA);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index ? Color(0xffe25353) : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      _finishOnboarding();
                    } else {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffe25353),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Selesai' : 'Lanjut',
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xffffffff)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
