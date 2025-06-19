import 'package:get/get.dart';

import '../controllers/streamlit_webview_controller.dart';

class StreamlitWebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreamlitWebviewController>(
      () => StreamlitWebviewController(),
    );
  }
}
