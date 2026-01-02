import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String token;

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    required this.token,
  });

  // Factory untuk convert JSON dari API ke Object Dart
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']
          .toString(), // Adjust sesuai response API reqres.in or real API
      email: json['email'] ?? '',
      name: json['first_name'] ?? 'User', // Contoh mapping field reqres.in
      token: json['token'] ?? '',
    );
  }

  // Method untuk convert Object Dart ke JSON (misal mau simpen ke local)
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'token': token};
  }

  @override
  List<Object?> get props => [id, email, name, token];
}
