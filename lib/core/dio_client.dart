/// ==========================================================
/// FILE: dio_client.dart
/// DESKRIPSI: HTTP Client untuk komunikasi dengan API Backend
///
/// File ini mengatur semua request ke server Laravel:
/// - Base URL (alamat server)
/// - Timeout (batas waktu tunggu)
/// - Token otomatis (untuk autentikasi)
/// - Logging (catat semua request/response)
///
/// Pakai pattern Singleton supaya cuma ada 1 instance
/// ==========================================================

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Kelas untuk handle semua HTTP request ke API
///
/// Contoh penggunaan:
/// ```dart
/// final dio = DioClient().dio;
/// final response = await dio.get('/berita');
/// ```
class DioClient {
  // ====================================
  // SINGLETON PATTERN
  // Supaya cuma ada 1 instance DioClient di seluruh app
  // Hemat memory dan konsisten
  // ====================================
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;

  /// Factory constructor - selalu return instance yang sama
  factory DioClient() {
    return _instance;
  }

  /// Private constructor - dipanggil sekali saat app pertama kali jalan
  DioClient._internal() {
    // ====================================
    // SETUP KONFIGURASI DASAR
    // ====================================
    _dio = Dio(
      BaseOptions(
        // ⚠️ PENTING: Ganti baseUrl sesuai kondisi Anda:
        // - Emulator Android: http://10.0.2.2:8000/api
        // - HP Fisik (WiFi sama): http://192.168.x.x:8000/api
        // - Production: https://api.anpundung.com/api
        baseUrl: 'http://10.0.2.2:8000/api',

        // Batas waktu tunggu (30 detik)
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),

        // Header default untuk semua request
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // ====================================
    // INTERCEPTOR: Otomatis tambah token & logging
    // ====================================
    _dio.interceptors.add(
      InterceptorsWrapper(
        // Sebelum request dikirim
        onRequest: (options, handler) async {
          debugPrint('📤 [Request] ${options.method} ${options.path}');
          debugPrint('   Data: ${options.data}');

          // Ambil token dari penyimpanan lokal
          final prefs = await SharedPreferences.getInstance();
          final String? token = prefs.getString('auth_token');

          // Kalau ada token, tambahkan ke header
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },

        // Kalau ada error
        onError: (DioException e, handler) {
          debugPrint('❌ [Error] ${e.type}');
          debugPrint('   Pesan: ${e.message}');
          debugPrint('   Status: ${e.response?.statusCode}');
          return handler.next(e);
        },

        // Kalau dapat response sukses
        onResponse: (response, handler) {
          debugPrint('✅ [Response] Status: ${response.statusCode}');
          debugPrint('   Path: ${response.requestOptions.path}');
          return handler.next(response);
        },
      ),
    );

    // Logger cantik buat debugging di terminal
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }

  /// Getter untuk akses Dio instance dari luar
  Dio get dio => _dio;
}
