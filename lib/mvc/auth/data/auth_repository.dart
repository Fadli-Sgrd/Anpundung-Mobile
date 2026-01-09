/// ==========================================================
/// FILE: auth_repository.dart
/// DESKRIPSI: Repository untuk semua hal terkait Autentikasi
///
/// Repository ini menangani:
/// - Login (masuk akun)
/// - Register (daftar akun baru)
/// - Logout (keluar akun)
/// - Simpan/ambil data user dari local storage
/// ==========================================================

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/dio_client.dart';
import 'user_model.dart';

/// Repository untuk mengelola autentikasi user
///
/// Contoh penggunaan:
/// ```dart
/// final authRepo = AuthRepository();
/// final user = await authRepo.login('email@test.com', 'password');
/// ```
class AuthRepository {
  final DioClient _dioClient = DioClient();

  // ====================================
  // LOGIN
  // Proses masuk ke akun yang sudah ada
  // ====================================
  Future<UserModel> login(String email, String password) async {
    try {
      // Kirim request ke API /login
      final response = await _dioClient.dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      // Kalau sukses (status 200)
      if (response.statusCode == 200) {
        final data = response.data['data'];

        // Buat object user dari response
        final user = UserModel(
          id: data['id'].toString(),
          email: data['email'],
          name: data['nama'],
          token: data['token'],
        );

        // Simpan token dan data user ke local storage
        await _saveToken(user.token);
        await _saveUser(user);

        return user;
      } else {
        throw Exception(response.data['message'] ?? 'Login gagal');
      }
    } on DioException catch (e) {
      // Handle error dari server
      if (e.response?.statusCode == 401) {
        throw Exception('Email atau password salah');
      }
      throw Exception(
        e.response?.data['message'] ?? 'Login gagal: ${e.message}',
      );
    } catch (e) {
      throw Exception('Error login: $e');
    }
  }

  // ====================================
  // HELPER: Simpan Token ke Local Storage
  // Token dipakai untuk autentikasi request selanjutnya
  // ====================================
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    debugPrint("✅ Token tersimpan");
  }

  // ====================================
  // HELPER: Simpan Data User ke Local Storage
  // Supaya bisa ditampilkan di profile tanpa request ulang
  // ====================================
  Future<void> _saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', user.name ?? 'Warga Bandung');
    await prefs.setString('user_email', user.email);
    debugPrint("✅ Data user tersimpan: ${user.name}");
  }

  // ====================================
  // GET USER DATA
  // Ambil data user yang tersimpan di local storage
  // ====================================
  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('user_name') ?? 'Warga Bandung',
      'email': prefs.getString('user_email') ?? '',
    };
  }

  // ====================================
  // LOGOUT
  // Proses keluar dari akun
  // ====================================
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      // Kalau ada token, hit API logout dulu
      if (token != null) {
        await _dioClient.dio.post(
          '/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
      }

      // Hapus semua data dari local storage
      await prefs.remove('auth_token');
      await prefs.remove('user_name');
      await prefs.remove('user_email');
      debugPrint("✅ Logout berhasil - Data dihapus");
    } catch (e) {
      debugPrint("❌ Error logout: $e");
      // Tetap hapus data meski API error
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_name');
      await prefs.remove('user_email');
    }
  }

  // ====================================
  // REGISTER
  // Proses daftar akun baru
  // ====================================
  Future<UserModel> register(String name, String email, String password) async {
    try {
      debugPrint('📤 Register: name=$name, email=$email');

      // Kirim request ke API /register
      final response = await _dioClient.dio.post(
        '/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      debugPrint('✅ Response: ${response.statusCode}');

      // Kalau sukses (status 201 atau 200)
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data['data'];

        // Buat object user dari response
        final user = UserModel(
          id: data['user']['id'].toString(),
          email: data['user']['email'],
          name: data['user']['name'],
          token: data['token'],
        );

        debugPrint('✅ User terdaftar: ${user.name}');

        // Simpan token dan data user
        await _saveToken(user.token);
        await _saveUser(user);

        return user;
      } else {
        throw Exception('Register gagal: ${response.data['message']}');
      }
    } on DioException catch (e) {
      debugPrint('❌ DioException: ${e.type}');
      debugPrint('❌ Response: ${e.response?.data}');

      // Ambil error message dari backend
      final errors = e.response?.data['errors'];
      final message =
          e.response?.data['message'] ?? e.message ?? 'Register gagal';

      throw RegisterException(message: message, errors: errors ?? {});
    } catch (e) {
      debugPrint('❌ Error: $e');
      throw RegisterException(message: 'Error tidak terduga: $e');
    }
  }
}

// ====================================
// CUSTOM EXCEPTION
// Exception khusus untuk error register dengan detail field
// ====================================
class RegisterException implements Exception {
  final String message; // Pesan error utama
  final Map<String, dynamic> errors; // Error per field (email, password, dll)

  RegisterException({required this.message, this.errors = const {}});

  @override
  String toString() => message;

  /// Ambil error untuk field tertentu
  /// Contoh: getFieldError('email') => 'Email sudah terdaftar'
  String? getFieldError(String fieldName) {
    if (errors.containsKey(fieldName)) {
      final errorList = errors[fieldName];
      if (errorList is List && errorList.isNotEmpty) {
        return errorList.first.toString();
      }
    }
    return null;
  }
}
