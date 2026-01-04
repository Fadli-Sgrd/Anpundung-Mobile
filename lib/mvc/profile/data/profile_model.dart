class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String? role;
  final String? phone;
  final String? address;
  final String? city;
  final DateTime createdAt;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.phone,
    this.address,
    this.city,
    required this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'address': address,
      'city': city,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
