import 'package:get_storage/get_storage.dart';

class HistoryDeviceHelper {
  static final _box = GetStorage();
  static const _keyDevices = 'history_devices';

  static Future<void> addDevice(Map<String, String> deviceInfo) async {
    final List<dynamic> current = _box.read<List>(_keyDevices) ?? [];

    final updated = [
      ...current,
      {
        ...deviceInfo,
        'timestamp': DateTime.now().toIso8601String(),
      },
    ];

    await _box.write(_keyDevices, updated);
  }

  static List<Map<String, dynamic>> getDevices() {
    final List<dynamic> data = _box.read<List>(_keyDevices) ?? [];
    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> clearDevices() async {
    await _box.remove(_keyDevices);
  }
}
