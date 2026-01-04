import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../core/dio_client.dart';
import 'dashboard_model.dart';

class DashboardRepository {
  final DioClient _dioClient = DioClient();

  // Get dashboard statistics
  Future<DashboardModel> getDashboard() async {
    try {
      debugPrint('📊 Fetching dashboard...');
      final response = await _dioClient.dio.get('/dashboard');

      if (response.statusCode == 200) {
        debugPrint('✅ Dashboard fetched: ${response.data}');
        
        final dashboardData = response.data['data'];
        return DashboardModel.fromJson(dashboardData as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load dashboard: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('❌ Dashboard Error: ${e.message}');
      throw Exception('Dashboard error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
