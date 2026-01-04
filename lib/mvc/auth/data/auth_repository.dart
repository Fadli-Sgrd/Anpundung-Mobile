import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/dio_client.dart';
import 'user_model.dart'; // Import Model

class AuthRepository {
  final DioClient _dioClient = DioClient();

  // Login Method
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dioClient.dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      // Pastikan response sukses (200)
      if (response.statusCode == 200) {
        final data = response.data['data'];
        
        final user = UserModel(
          id: data['id'].toString(),
          email: data['email'],
          name: data['nama'],
          token: data['token'],
        );
        
        // Simpan token
        await _saveToken(user.token);
        
        return user;
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      // Handle error response dari server
      if (e.response?.statusCode == 401) {
        throw Exception('Email atau password salah');
      }
      throw Exception(e.response?.data['message'] ?? 'Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Login error: $e');
    }
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
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Get token untuk hit API logout
      final token = prefs.getString('auth_token');
      
      if (token != null) {
        // Hit API logout
        await _dioClient.dio.post(
          '/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
      }
      
      // Clear token dari local storage
      await prefs.remove('auth_token');
      debugPrint("Logout berhasil - Token dihapus");
    } catch (e) {
      debugPrint("Error logout: $e");
      // Tetap clear token meski API error
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    }
  }

  // ====================================
  // Register Method - BARU
  // ====================================
  Future<UserModel> register(String name, String email, String password) async {
    try {
      debugPrint('📤 Register Request: name=$name, email=$email, password=$password');
      
      final response = await _dioClient.dio.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      
      debugPrint('✅ Register Response Status: ${response.statusCode}');
      debugPrint('✅ Register Response Data: ${response.data}');
      
      // Pastikan status sukses
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data['data'];
        
        final user = UserModel(
          id: data['user']['id'].toString(),
          email: data['user']['email'],
          name: data['user']['name'],
          token: data['token'],
        );
        
        debugPrint('✅ User created: ${user.name} (${user.email})');
        
        // Simpan token
        await _saveToken(user.token);
        
        return user;
      } else {
        throw Exception('Register failed: ${response.data['message']}');
      }
    } on DioException catch (e) {
      debugPrint('❌ DioException: ${e.type}');
      debugPrint('❌ Error Message: ${e.message}');
      debugPrint('❌ Response Status: ${e.response?.statusCode}');
      debugPrint('❌ Response Data: ${e.response?.data}');
      
      // Handle error dari backend
      final errors = e.response?.data['errors'];
      final message = e.response?.data['message'] ?? e.message ?? 'Register failed';
      
      throw RegisterException(
        message: message,
        errors: errors ?? {},
      );
    } catch (e) {
      debugPrint('❌ Unexpected Error: $e');
      throw RegisterException(
        message: 'Unexpected error: $e',
      );
    }
  }
}

// ====================================
// Custom Exception - BARU
// ====================================
class RegisterException implements Exception {
  final String message;
  final Map<String, dynamic> errors;
  
  RegisterException({
    required this.message,
    this.errors = const {},
  });
  
  @override
  String toString() => message;
  
  // Helper untuk ambil error per field
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
