/// ==========================================================
/// FILE: user_model.dart
/// DESKRIPSI: Model data untuk User (pengguna aplikasi)
///
/// Model ini merepresentasikan data user yang login:
/// - id: ID unik user
/// - email: Alamat email
/// - name: Nama lengkap
/// - token: Token autentikasi untuk API
/// ==========================================================

import 'package:equatable/equatable.dart';

/// Model User - menyimpan data pengguna yang sedang login
class UserModel extends Equatable {
  final String id; // ID unik user dari database
  final String email; // Alamat email user
  final String? name; // Nama lengkap (opsional)
  final String token; // Token JWT untuk autentikasi

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    required this.token,
  });

  /// Buat UserModel dari JSON response API
  /// Dipakai setelah login/register berhasil
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'] ?? '',
      name: json['first_name'] ?? 'User',
      token: json['token'] ?? '',
    );
  }

  /// Konversi ke JSON untuk disimpan ke local storage
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'token': token};
  }

  @override
  List<Object?> get props => [id, email, name, token];
}
