import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/dio_client.dart';
import 'kontak_model.dart';

/// Repository untuk mengelola operasi API terkait Kontak
///
/// Repository ini bertanggung jawab untuk:
/// 1. Mengirim pesan kontak ke backend Laravel
/// 2. Menangani response sukses/gagal dari API
///
/// Pattern: Repository Pattern (memisahkan logic akses data dari UI)
class KontakRepository {
  final Dio _dio = DioClient().dio;

  /// Mengirim pesan kontak ke API backend
  ///
  /// [kontak] - Model yang berisi data: nama, email, subject, message
  ///
  /// Return:
  /// - `true` jika berhasil (status code 201)
  /// - `false` jika gagal
  ///
  /// Throws [DioException] jika terjadi error jaringan
  ///
  /// Endpoint: POST /api/kontak
  ///
  /// Response sukses dari backend:
  /// ```json
  /// {
  ///   "status": true,
  ///   "message": "Pesan berhasil dikirim",
  ///   "data": { ... }
  /// }
  /// ```
  Future<Map<String, dynamic>> kirimPesan(KontakModel kontak) async {
    try {
      debugPrint('📤 [KontakRepository] Mengirim pesan kontak...');
      debugPrint('   Data: ${kontak.toJson()}');

      final response = await _dio.post(
        '/kontak', // Endpoint API sesuai route Laravel
        data: kontak.toJson(),
      );

      debugPrint('✅ [KontakRepository] Response: ${response.data}');

      // Cek response status dari backend
      // Backend Laravel return status: true jika sukses
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;

        // Validasi struktur response sesuai KontakController
        if (data['status'] == true) {
          return {
            'success': true,
            'message': data['message'] ?? 'Pesan berhasil dikirim',
          };
        }
      }

      // Jika sampai sini berarti ada masalah dengan response
      return {
        'success': false,
        'message': 'Gagal mengirim pesan, silakan coba lagi',
      };
    } on DioException catch (e) {
      debugPrint('❌ [KontakRepository] DioException: ${e.message}');
      debugPrint('   Response: ${e.response?.data}');

      // Handle validation error (422) dari Laravel
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        String errorMessage = 'Validasi gagal: ';

        if (errors != null && errors is Map) {
          // Ambil pesan error pertama dari setiap field
          errors.forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              errorMessage += '${value.first} ';
            }
          });
        }

        return {'success': false, 'message': errorMessage.trim()};
      }

      // Handle error server (500)
      if (e.response?.statusCode == 500) {
        return {
          'success': false,
          'message': 'Server sedang bermasalah, coba lagi nanti',
        };
      }

      // Handle error koneksi
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        return {
          'success': false,
          'message':
              'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
        };
      }

      // Default error message
      return {
        'success': false,
        'message':
            e.response?.data?['message'] ??
            'Terjadi kesalahan, silakan coba lagi',
      };
    } catch (e) {
      debugPrint('❌ [KontakRepository] Unexpected error: $e');
      return {'success': false, 'message': 'Terjadi kesalahan tidak terduga'};
    }
  }
}
