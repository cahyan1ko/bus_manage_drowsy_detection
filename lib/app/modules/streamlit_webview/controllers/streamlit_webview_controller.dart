import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StreamlitWebviewController extends GetxController {
  var isLoading = true.obs;

  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            isLoading.value = true;
          },
          onPageFinished: (_) {
            isLoading.value = false;
          },
          onWebResourceError: (error) {
            isLoading.value = false;
            print('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://cp0data-visual-cuaca.streamlit.app/'));
  }
}
