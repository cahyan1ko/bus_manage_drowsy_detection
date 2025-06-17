import 'package:get/get.dart';

import '../controllers/setting_history_controller.dart';

class SettingHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingHistoryController>(
      () => SettingHistoryController(),
    );
  }
}
