import 'package:capstone_bus_manage/app/data/providers/api_services.dart';
import 'package:capstone_bus_manage/app/utils/storage_helper.dart';
import 'package:get/get.dart';

class SettingsHistoryDevicesController extends GetxController {
   var devices = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchDeviceHistory();
    super.onInit();
  }

  Future<void> fetchDeviceHistory() async {
    try {
      isLoading.value = true;
      final userId = await StorageHelper.userId;
      if (userId != null) {
        final result = await ApiServices.getDeviceHistory(userId);
        devices.assignAll(result);
      }
    } catch (e) {
      print('Error fetching device history: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
