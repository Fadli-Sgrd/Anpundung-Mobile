import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/dio_client.dart';
import 'user_model.dart'; // Import Model

class AuthRepository {
  final DioClient _dioClient = DioClient();

  // Login Method
  Future<UserModel> login(String email, String password) async {
    // --- MODE MOCK / DUMMY BIAR CEPET (GA PAKE INTERNET) ---
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Pura-pura loading 1 detik

    // Validasi dummy
    if (email.isNotEmpty && password.isNotEmpty) {
      final user = UserModel(
        id: "1",
        email: email,
        name: "Mahasiswa Teladan",
        token: "dummy_token_12345",
      );
      await _saveToken(user.token);
      return user;
    } else {
      throw Exception("Email dan Password tidak boleh kosong!");
    }

    /* 
    // --- KALO MAU PAKE API BENERAN (reqres.in) ---
    try {
      final response = await _dioClient.dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      final token = response.data['token'];
      final user = UserModel(id: "1", email: email, name: "Admin", token: token);
      await _saveToken(token);
      return user;
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Login Failed');
    }
    */
  }

  // Helper Simpan Token
  Future<void> _saveToken(String token) async {
    // TEMPORARY FIX: Bypass SharedPreferences biar ga error PlatformException
    // karena belum rebuild native app. Nanti uncomment kalo udah rebuild.

    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('auth_token', token);
    debugPrint("Mock Token Saved: $token");
  }

  // Helper Clear Token (Logout)
  Future<void> logout() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('auth_token');
    debugPrint("Mock Logout");
  }
}
