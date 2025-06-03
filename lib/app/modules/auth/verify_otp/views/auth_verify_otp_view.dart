import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  int _resendCooldown = 180;
  bool _canResend = false;
  Timer? _resendTimer;

  void startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCooldown = 10;
    });

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _resendCooldown--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String getOtp() {
    return _controllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/logo-busty.png', width: 100),
                const SizedBox(height: 16),
                const Text(
                  'Verifikasi OTP',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Masukkan 6 digit kode OTP",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 45,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          counterText: '',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
                              width: 1.5,
                            ),
                          ),
                        ),
                        onChanged: (value) => _onChanged(value, index),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    final otp = getOtp();
                    if (otp.length == 6) {
                      Get.snackbar("Kode OTP", "OTP Anda: $otp");
                      // TODO: Lanjutkan proses verifikasi...
                    } else {
                      Get.snackbar("Error", "OTP belum lengkap");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE25353),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Verifikasi"),
                ),
                TextButton(
                  onPressed: _canResend
                      ? () {
                          Get.snackbar(
                              "Resend OTP", "Kode OTP telah dikirim ulang.");
                          startResendTimer();
                        }
                      : null,
                  child: Text(
                    _canResend
                        ? "Resend Code"
                        : "Resend in ${_resendCooldown ~/ 60}:${(_resendCooldown % 60).toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: _canResend ? Colors.redAccent : Colors.grey,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Kembali"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
