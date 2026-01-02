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
        // Ganti sama URL API asli / localhost (pake 10.0.2.2 kalo emulator android)
        baseUrl: 'https://reqres.in/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
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
          // Global Error Handling
          // Bisa tambah logic handle 401 (Unauthorized) -> Logout otomatis
          return handler.next(e);
        },
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
