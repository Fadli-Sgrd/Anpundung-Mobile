import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  // Singleton Pattern biar 1 instance aja (Modul 13)
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;

  // Private Constructor
  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    // Setup Base URL & Timeout
    _dio = Dio(
      BaseOptions(
        // ⚠️ PENTING: Update baseUrl sesuai backend Anda
        // Untuk Emulator Android: http://10.0.2.2:8000/api
        // Untuk Device Fisik: http://192.168.1.14:8000/api (Konfigurasi device Anda)
        // Untuk Production: https://api.yourdomain.com/api
        baseUrl: 'http://192.168.1.14:8000/api', // Device IP Anda
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add Interceptors (Modul 13)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          debugPrint('📤 [Dio Request] ${options.method} ${options.path}');
          debugPrint('   Headers: ${options.headers}');
          debugPrint('   Data: ${options.data}');
          
          // Ambil Token dari SharedPrefs (Modul 13: Auth Token)
          final prefs = await SharedPreferences.getInstance();
          final String? token = prefs.getString('auth_token');

          if (token != null) {
            options.headers['Authorization'] =
                'Bearer $token'; // Auto-attach Token
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          debugPrint('❌ [Dio Error] Type: ${e.type}');
          debugPrint('   Message: ${e.message}');
          debugPrint('   Status: ${e.response?.statusCode}');
          debugPrint('   Path: ${e.requestOptions.path}');
          return handler.next(e);
        },
        onResponse: (response, handler) {
          debugPrint('✅ [Dio Response] Status: ${response.statusCode}');
          debugPrint('   Path: ${response.requestOptions.path}');
          debugPrint('   Data: ${response.data}');
          return handler.next(response);
        }
      ),
    );

    // Pretty Logger biar enak liat log di Terminal
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }

  // Getter biar class lain bisa pake _dio instance ini
  Dio get dio => _dio;
}
