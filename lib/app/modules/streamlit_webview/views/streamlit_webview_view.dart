import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/streamlit_webview_controller.dart';

class StreamlitWebviewView extends GetView<StreamlitWebviewController> {
  const StreamlitWebviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff9f9f9),
        title: const Text('Cek Cuaca Tujuan'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          WebViewWidget(controller: controller.webViewController),
          Obx(() {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
