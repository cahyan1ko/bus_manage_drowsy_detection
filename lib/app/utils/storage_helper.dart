import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static late GetStorage _box;

  // Keys
  static const _keyToken = 'token';
  static const _keyEmail = 'email';
  static const _keyUsername = 'username';
  static const _keyUserId = 'user_id';
  static const _keyHasPassword = 'hasPassword';
  static const _keyOnboardingSeen = 'onboarding_seen';

  /// Init harus dipanggil sebelum penggunaan StorageHelper
  static Future<void> init() async {
    _box = GetStorage();
    await GetStorage.init();
  }

  // Write methods
  static void saveUser({
    required String token,
    required String email,
    required String username,
    required String userId,
    required bool hasPassword,
  }) {
    write(_keyToken, token);
    write(_keyEmail, email);
    write(_keyUsername, username);
    write(_keyUserId, userId);
    write(_keyHasPassword, hasPassword);
  }

  /// Write data by key
  static Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  /// Read data by key
  static T? read<T>(String key) {
    return _box.read<T>(key);
  }

  /// Remove data by key
  static Future<void> remove(String key) async {
    await _box.remove(key);
  }

  /// Clear all storage
  static Future<void> clear() async {
    print('DEBUG: StorageHelper.clear() dipanggil');
    await _box.erase();
    print('DEBUG: Storage setelah erase = ${_box.read('token')}'); // harus null
  }

  // Specific read getters
  static String? get token => read<String>(_keyToken);
  static String? get email => read<String>(_keyEmail);
  static String? get username => read<String>(_keyUsername);
  static String? get userId => read<String>(_keyUserId);
  static bool get hasPassword => read<bool>(_keyHasPassword) ?? true;

  // Login check
  static bool get isLoggedIn => token != null && token!.isNotEmpty;

  /// Simpan status bahwa onboarding sudah pernah dilihat
  static Future<void> setOnboardingSeen() async {
    await write(_keyOnboardingSeen, true);
  }

  /// Cek apakah onboarding sudah pernah dilihat
  static bool get onboardingSeen => read<bool>(_keyOnboardingSeen) ?? false;
}
