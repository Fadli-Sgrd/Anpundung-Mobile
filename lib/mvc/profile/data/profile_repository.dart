import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../core/dio_client.dart';
import 'profile_model.dart';

class ProfileRepository {
  final DioClient _dioClient = DioClient();

  // Get current user profile
  Future<ProfileModel> getProfile() async {
    try {
      debugPrint('👤 Fetching profile...');
      final response = await _dioClient.dio.get('/profile');

      if (response.statusCode == 200) {
        debugPrint('✅ Profile fetched: ${response.data}');
        
        final profileData = response.data['data'];
        return ProfileModel.fromJson(profileData as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('❌ Profile Error: ${e.message}');
      throw Exception('Profile error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  // Update profile
  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? city,
  }) async {
    try {
      debugPrint('👤 Updating profile...');
      
      final response = await _dioClient.dio.post(
        '/profile',
        data: {
          'name': name,
          'email': email,
          if (phone != null) 'phone': phone,
          if (address != null) 'address': address,
          if (city != null) 'city': city,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('✅ Profile updated');
        final profileData = response.data['data'];
        return ProfileModel.fromJson(profileData as Map<String, dynamic>);
      } else {
        throw Exception('Failed to update profile');
      }
    } on DioException catch (e) {
      throw Exception('Update profile error: ${e.message}');
    }
  }
}
