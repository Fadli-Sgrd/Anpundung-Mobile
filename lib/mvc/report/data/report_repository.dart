import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../core/dio_client.dart';
import 'report_model.dart';

class ReportRepository {
  final DioClient _dioClient = DioClient();

  // Get Reports
  Future<List<ReportModel>> getReports() async {
    try {
      debugPrint('📝 Fetching reports...');
      final response = await _dioClient.dio.get('/laporan');

      if (response.statusCode == 200) {
        debugPrint('✅ Reports fetched: ${response.data}');
        final List<dynamic> reportsData = response.data['data'] ?? [];
        return reportsData
            .map((json) => ReportModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load reports');
      }
    } on DioException catch (e) {
      debugPrint('❌ Report Error: ${e.message}');
      throw Exception('Report error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  // Helper to map category name to ID
  int _getCategoryId(String name) {
    switch (name.toLowerCase()) {
      case 'pungli':
        return 1;
      case 'penipuan':
        return 2;
      case 'pemerasan':
        return 3;
      case 'korupsi':
        return 4;
      case 'suap':
        return 5;
      default:
        return 6; // Lainnya
    }
  }

  // Add Report
  Future<void> addReport({
    required String title,
    required String description,
    required String location,
    required String date, // Format YYYY-MM-DD
    required String categoryName,
  }) async {
    try {
      debugPrint('📝 Adding report: $title');

      final data = {
        'judul': title,
        'deskripsi': description,
        'alamat': location,
        'tanggal': date,
        'id_kategori': _getCategoryId(categoryName),
      };

      final response = await _dioClient.dio.post('/laporan', data: data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint('✅ Report added successfully');
      } else {
        throw Exception('Failed to add report: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('❌ Add Report Error: ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Add report failed');
    }
  }

  // Delete Report
  Future<void> deleteReport(String id) async {
    try {
      debugPrint('🗑️ Deleting report: $id');
      final response = await _dioClient.dio.delete('/laporan/$id');

      if (response.statusCode == 200) {
        debugPrint('✅ Report deleted successfully');
      } else {
        throw Exception('Failed to delete report: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('❌ Delete Report Error: ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Delete report failed');
    }
  }
}
