/// ==========================================================
/// FILE: kategori_model.dart
/// DESKRIPSI: Model data untuk Kategori Laporan
///
/// Model ini merepresentasikan satu kategori laporan:
/// - id: ID unik kategori
/// - nama: Nama kategori (Pungli, Korupsi, dll)
/// - deskripsi: Penjelasan kategori (opsional)
///
/// Data diambil dari API: GET /api/kategori
/// ==========================================================

/// Model Kategori - menyimpan data satu kategori laporan
class KategoriModel {
  final int id; // ID unik dari database
  final String nama; // Nama kategori
  final String? deskripsi; // Penjelasan (opsional)

  KategoriModel({required this.id, required this.nama, this.deskripsi});

  /// Buat KategoriModel dari JSON response API
  ///
  /// Mendukung berbagai format field name:
  /// - nama / name / nama_kategori
  /// - deskripsi / description / keterangan
  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      nama: json['nama'] ?? json['name'] ?? json['nama_kategori'] ?? '',
      deskripsi: json['deskripsi'] ?? json['description'] ?? json['keterangan'],
    );
  }

  /// Konversi ke JSON (untuk disimpan/dikirim)
  Map<String, dynamic> toJson() {
    return {'id': id, 'nama': nama, 'deskripsi': deskripsi};
  }

  @override
  String toString() => 'KategoriModel(id: $id, nama: $nama)';
}
