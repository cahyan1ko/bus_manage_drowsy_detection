import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/rute_model.dart';

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

  static Future<List<RuteModel>> getRuteByUser(String userId, String token) async {
    final url = Uri.parse('$baseUrl/rute/user/$userId');
    
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // jika API kamu pakai auth
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((rute) => RuteModel.fromJson(rute)).toList();
    } else {
      throw Exception('Gagal memuat data rute');
    }
  }
}
