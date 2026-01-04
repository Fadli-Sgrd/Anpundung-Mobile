import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../core/dio_client.dart';
import 'news_model.dart';

class NewsRepository {
  final DioClient _dioClient = DioClient();

  // Get all news
  Future<List<NewsModel>> getNews() async {
    try {
      debugPrint('📰 Fetching news...');
      final response = await _dioClient.dio.get('/berita');

      if (response.statusCode == 200) {
        debugPrint('✅ News fetched: ${response.data}');
        
        final List<dynamic> newsList = response.data['data'] ?? [];
        return newsList
            .map((news) => NewsModel.fromJson(news as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('❌ News Error: ${e.message}');
      throw Exception('News error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  // Get news by slug
  Future<NewsModel> getNewsBySlug(String slug) async {
    try {
      debugPrint('📰 Fetching news: $slug');
      final response = await _dioClient.dio.get('/berita/$slug');

      if (response.statusCode == 200) {
        final newsData = response.data['data'];
        return NewsModel.fromJson(newsData as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load news detail');
      }
    } on DioException catch (e) {
      throw Exception('News detail error: ${e.message}');
    }
  }
}
