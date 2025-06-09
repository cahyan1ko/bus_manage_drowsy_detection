import 'package:capstone_bus_manage/app/routes/app_pages.dart';
import 'package:capstone_bus_manage/app/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      final seen = await StorageHelper.onboardingSeen;
      if (seen) {
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
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo-busty.png'),
          width: 160,
        ),
      ),
    );
  }
}
