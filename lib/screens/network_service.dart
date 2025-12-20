import 'package:dio/dio.dart';

class NetworkService {
  final Dio _dio = Dio();

  NetworkService() {
    // Konfigurasi dasar Dio 
    _dio.options.baseUrl = "https://api.bandung.go.id"; // Contoh URL
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    
    // Nambahin Interceptor buat logging (biar tau kalau ada error di console)
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  // Contoh fungsi GET
  Future<Response> getReports() async {
    try {
      return await _dio.get('/laporan');
    } catch (e) {
      rethrow;
    }
  }

  // Contoh fungsi POST
  Future<Response> postReport(Map<String, dynamic> data) async {
    try {
      return await _dio.post('/laporan', data: data);
    } catch (e) {
      rethrow;
    }
  }
}