import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/dio_client.dart';
import 'kategori_model.dart';

/// Repository untuk mengambil data kategori dari API
///
/// Endpoint: GET /api/kategori
class KategoriRepository {
  final Dio _dio = DioClient().dio;

  /// Mengambil semua kategori dari API
  ///
  /// Return: List<KategoriModel> jika sukses
  /// Throws: Exception jika gagal
  Future<List<KategoriModel>> getKategori() async {
    try {
      debugPrint('📤 [KategoriRepository] Mengambil data kategori...');

      final response = await _dio.get('/kategori');

      debugPrint('✅ [KategoriRepository] Response: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        // Handle berbagai format response dari Laravel
        List<dynamic>? kategoris;

        // Format 1: { "status": true, "data": [...] }
        if (data is Map && data['data'] != null) {
          kategoris = data['data'] as List<dynamic>;
        }
        // Format 2: { "kategoris": [...] }
        else if (data is Map && data['kategoris'] != null) {
          kategoris = data['kategoris'] as List<dynamic>;
        }
        // Format 3: langsung array [...]
        else if (data is List) {
          kategoris = data;
        }

        if (kategoris != null && kategoris.isNotEmpty) {
          debugPrint(
            '📋 [KategoriRepository] Found ${kategoris.length} kategori',
          );
          return kategoris.map((json) => KategoriModel.fromJson(json)).toList();
        }
      }

      debugPrint('⚠️ [KategoriRepository] No kategori found in response');
      return [];
    } on DioException catch (e) {
      debugPrint('❌ [KategoriRepository] DioException: ${e.message}');
      debugPrint('   Response: ${e.response?.data}');

      // Return empty list jika error, biar UI tetap jalan
      return [];
    } catch (e) {
      debugPrint('❌ [KategoriRepository] Unexpected error: $e');
      return [];
    }
  }
}
