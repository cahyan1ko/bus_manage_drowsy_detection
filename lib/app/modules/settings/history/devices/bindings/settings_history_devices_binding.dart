import 'package:get/get.dart';

import '../controllers/settings_history_devices_controller.dart';

class SettingsHistoryDevicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsHistoryDevicesController>(
      () => SettingsHistoryDevicesController(),
    );
  }
}
