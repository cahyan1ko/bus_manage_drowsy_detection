import 'package:capstone_bus_manage/app/routes/app_pages.dart';
import 'package:capstone_bus_manage/app/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _jumpAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Naik tinggi lalu turun ringan
    _jumpAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -100.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -100.0, end: -20.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _controller.forward().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 500));

      final seen = await StorageHelper.onboardingSeen;
      if (!seen) {
        Get.offAllNamed(Routes.ONBOARDING);
      } else {
        if (StorageHelper.isLoggedIn) {
          Get.offAllNamed(Routes.BERANDA);
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _jumpAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _jumpAnimation.value),
              child: child,
            );
          },
          child: SvgPicture.asset(
            'assets/images/travion_ls.svg',
            width: 220,
          ),
        ),
      ),
    );
  }
}
