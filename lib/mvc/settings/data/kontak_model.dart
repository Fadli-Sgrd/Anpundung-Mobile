/// Model Kontak untuk mengirim pesan ke Admin
///
/// Model ini merepresentasikan data yang dikirim ke API `/api/kontak`
/// sesuai dengan validasi di KontakController Laravel:
/// - nama: required, string, max 255
/// - email: required, email format
/// - subject: required, string, max 255
/// - message: required, string
class KontakModel {
  final String nama;
  final String email;
  final String subject;
  final String message;

  KontakModel({
    required this.nama,
    required this.email,
    required this.subject,
    required this.message,
  });

  /// Konversi model ke Map untuk dikirim ke API
  ///
  /// Menghasilkan struktur JSON yang sesuai dengan
  /// endpoint POST /api/kontak di backend Laravel
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'email': email,
      'subject': subject,
      'message': message,
    };
  }

  /// Factory constructor untuk membuat instance dari JSON response
  ///
  /// Digunakan saat menerima response dari API setelah berhasil
  /// menyimpan data kontak
  factory KontakModel.fromJson(Map<String, dynamic> json) {
    return KontakModel(
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
