import 'dart:convert';
import 'package:capstone_bus_manage/app/utils/storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/rute_model.dart';
import '../models/artikel_model.dart';

class ApiServices {
  static const String baseUrl = 'https://busservice-app.vercel.app/api';

  static Future<UserModel> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(data);
    } else {
      return UserModel.error(data['message'] ?? 'Username atau password salah');
    }
  }

  // google-login

  static Future<UserModel> googleLogin(String idToken) async {
    final url = Uri.parse('$baseUrl/google-login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_token': idToken,
      }),
    );

    print("Google Login Status: ${response.statusCode}");
    print("Google Login Body: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(data);
    } else {
      return UserModel.error(data['message'] ?? 'Login Google gagal');
    }
  }

  // save device

  static Future<void> sendDeviceInfo({
    required String userId,
    required String deviceName,
    required String deviceOS,
    required String deviceId,
  }) async {
    final url = Uri.parse('$baseUrl/device-history');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'device_name': deviceName,
          'device_os': deviceOS,
          'device_id': deviceId,
        }),
      );

      print('Device Info Response: ${response.statusCode}');
      print('Device Info Body: ${response.body}');

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Gagal mengirim data perangkat');
      }
    } catch (e) {
      print('Error sending device info: $e');
    }
  }

  // get device

  static Future<List<Map<String, dynamic>>> getDeviceHistory(
      String userId) async {
    final url = Uri.parse('$baseUrl/device-history/$userId');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Gagal mengambil riwayat perangkat');
    }
  }

  // register

  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    print("Register Response Status: ${response.statusCode}");
    print("Register Response Body: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'status': true,
        'message': data['message'],
      };
    } else {
      return {
        'status': false,
        'message': data['message'] ?? 'Registrasi gagal',
      };
    }
  }

  // verify-otp

  static Future<Map<String, dynamic>> verifyOtp({
    required String otp,
    required String email,
  }) async {
    final url = Uri.parse('$baseUrl/verify-otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'otp': otp,
          'email': email,
        }),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 400 ||
          response.statusCode == 404) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return {
          'status': 'error',
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  static Future<List<RuteModel>> getRuteByUser(
      String userId, String token) async {
    final url = Uri.parse('$baseUrl/rute/user/$userId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((rute) => RuteModel.fromJson(rute)).toList();
    } else {
      throw Exception('Gagal memuat data rute');
    }
  }

  static Future<bool> sendTrackingData({
    required String userId,
    required double lat,
    required double lng,
    required String labelDetection,
  }) async {
    final url = Uri.parse('$baseUrl/tracking');

    final body = {
      "user_id": userId,
      "lat": lat,
      "lng": lng,
      "label_detection": labelDetection,
    };

    print("📦 Payload:");
    print(jsonEncode(body));

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print("📡 Status Code: ${response.statusCode}");
      print("📝 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Tracking data sent successfully.");
        return true;
      } else {
        print("⚠️ Failed to send tracking data: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Error sending tracking data: $e");
      return false;
    }
  }

  static Future<bool> stopTracking({required String userId}) async {
    final url = Uri.parse('$baseUrl/stop-tracking');

    final body = {
      "user_id": userId,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("✅ Tracking berhasil dihentikan.");
        return true;
      } else {
        print("⚠️ Gagal menghentikan tracking: ${response.statusCode}");
        print("Body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Error saat mengirim permintaan stopTracking: $e");
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getRiwayatOperasional({
    required String userId,
  }) async {
    final url = Uri.parse('$baseUrl/riwayat-operasional');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> riwayatList = data['data'];

        // print(
        //     "✅ Riwayat operasional berhasil diambil: ${riwayatList.length} data");

        // Convert to List<Map<String, dynamic>> for better handling
        return riwayatList.cast<Map<String, dynamic>>();
      } else {
        // print("⚠️ Gagal mengambil riwayat: ${response.statusCode}");
        // print(response.body);
        return [];
      }
    } catch (e) {
      print("❌ Error saat mengambil riwayat: $e");
      return [];
    }
  }

  static Future<List<ArtikelModel>> fetchArtikel() async {
    final url = Uri.parse('$baseUrl/artikel');
    final response = await http.get(url);

    // print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      // // DEBUG setiap item
      // for (var item in data) {
      //   print("Artikel item: $item");
      // }

      return data.map((json) => ArtikelModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat artikel');
    }
  }

  static Future<ArtikelModel> fetchArtikelDetail(String artikelId) async {
    final url = Uri.parse('$baseUrl/artikel/$artikelId');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ArtikelModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat detail artikel');
    }
  }

  static Future<bool> updateProfil({String? nomorHp, String? alamat}) async {
    final userId = await StorageHelper.userId;

    if (userId == null) {
      throw Exception('User ID tidak ditemukan.');
    }

    final url = Uri.parse('$baseUrl/edit-profil');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'user_id': userId,
      if (nomorHp != null) 'nomor_hp': nomorHp,
      if (alamat != null) 'alamat': alamat,
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Profil berhasil diperbarui: ${response.body}');
      return true;
    } else {
      print('Gagal memperbarui profil: ${response.body}');
      return false;
    }
  }
}
