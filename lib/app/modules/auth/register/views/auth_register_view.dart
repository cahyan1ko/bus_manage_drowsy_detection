import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRegisterView extends StatefulWidget {
  const AuthRegisterView({super.key});

  @override
  State<AuthRegisterView> createState() => _AuthRegisterViewState();
}

class _AuthRegisterViewState extends State<AuthRegisterView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  void register() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Simulasi proses register
    await Future.delayed(const Duration(seconds: 2));

    // Contoh validasi dummy
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _noHpController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() {
        errorMessage = "Semua field harus diisi.";
        isLoading = false;
      });
    } else {
      // Anggap sukses
      setState(() {
        isLoading = false;
      });

      // Navigasi atau tampilkan snackbar
      Get.snackbar("Sukses", "Registrasi berhasil!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/logo-busty.png', width: 100),
                const SizedBox(height: 16),
                const Text(
                  'Create your account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (errorMessage.isNotEmpty)
                  Text(errorMessage, style: TextStyle(color: Colors.red)),
                const SizedBox(height: 10),
                TextField(
                  controller: _usernameController,
                  decoration: _inputDecoration('Username'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: _inputDecoration('Email'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _noHpController,
                  decoration: _inputDecoration('Password'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _inputDecoration('Confirm Password'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE25353),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Register'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah punya akun?"),
                    TextButton(
                      onPressed: () {
                        Get.back(); // kembali ke login
                      },
                      child: const Text("Login di sini"),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
