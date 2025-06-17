import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

class DeviceHelper {
  static Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return {
        'device_name': androidInfo.model ?? 'Unknown Android',
        'device_os': 'Android ${androidInfo.version.release}',
        'device_id': androidInfo.id ?? const Uuid().v4(), 
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return {
        'device_name': iosInfo.name ?? 'iPhone',
        'device_os': '${iosInfo.systemName} ${iosInfo.systemVersion}',
        'device_id': iosInfo.identifierForVendor ?? const Uuid().v4(),
      };
    }

    return {
      'device_name': 'Unknown',
      'device_os': 'Unknown',
      'device_id': const Uuid().v4(),
    };
  }
}
