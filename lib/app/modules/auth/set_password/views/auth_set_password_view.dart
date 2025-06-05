import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_set_password_controller.dart';

class AuthSetPasswordView extends GetView<AuthSetPasswordController> {
  const AuthSetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(
                          child: Text(
                            'Atur Password Baru',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: controller.passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                          decoration: _inputDecoration('Password Baru'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: controller.confirmPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Konfirmasi password tidak boleh kosong';
                            }
                            if (value != controller.passwordController.text) {
                              return 'Password tidak cocok';
                            }
                            return null;
                          },
                          decoration: _inputDecoration('Konfirmasi Password'),
                        ),
                        const SizedBox(height: 24),
                        Obx(() => SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor:
                                      const Color(0xFFE25353), // merah
                                ),
                                onPressed: controller.isLoading.value
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          controller.setPassword();
                                        }
                                      },
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Simpan Password',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            )),
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
            ),

            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 28,
                color: const Color(0xFFE25353),
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
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }
}
