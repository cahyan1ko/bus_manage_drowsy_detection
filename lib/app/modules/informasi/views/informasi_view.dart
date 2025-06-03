import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/informasi_controller.dart';

class InformasiView extends StatelessWidget {
  const InformasiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('InformasiView')),
      body: Center(child: Text('Halaman Informasi - tanpa controller')),
    );
  }
}
