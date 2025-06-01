import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_forgot_password_controller.dart';

class ForgotPasswordView extends GetView<AuthForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: Stack(
          children: [
            // Konten utama di tengah vertikal dan horizontal
            Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        600, // Optional: supaya tidak terlalu melebar di layar besar
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // biar tingginya minimal
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset('assets/images/logo-busty.png',
                            width: 100),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Reset Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Masukkan email kamu untuk mendapatkan link reset.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: formKey,
                        child: TextFormField(
                          onChanged: (value) => controller.email.value = value,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Format email tidak valid';
                            }
                            return null;
                          },
                          decoration: _inputDecoration('Email'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color(0xFFE25353),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Kirim Link Reset',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() => controller.message.value.isNotEmpty
                          ? Text(
                              controller.message.value,
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 14),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox.shrink()),
                    ],
                  ),
                ),
              ),
            ),

            // Back button fixed di atas kiri
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 28,
                color: Color(0xFFE25353),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), // radius lebih besar
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.redAccent, // warna saat fokus, bisa sesuaikan
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }
}
