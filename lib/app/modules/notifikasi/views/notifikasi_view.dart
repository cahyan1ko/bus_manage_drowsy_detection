import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends StatelessWidget {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotifikasiController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('NotifikasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NotifikasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
