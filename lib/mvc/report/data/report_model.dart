/// ==========================================================
/// FILE: report_model.dart
/// DESKRIPSI: Model data untuk Laporan Pungli
///
/// Model ini merepresentasikan satu laporan yang dibuat user:
/// - id: Kode unik laporan (misal: LAP-001)
/// - title: Judul laporan
/// - description: Deskripsi/kronologi kejadian
/// - location: Lokasi kejadian
/// - category: Kategori laporan (Pungli, Korupsi, dll)
/// - status: Status tindakan (Pending, Diproses, Selesai)
/// ==========================================================

import 'package:equatable/equatable.dart';

/// Model Laporan - menyimpan data satu laporan pungli
class ReportModel extends Equatable {
  final String id; // Kode laporan unik
  final String title; // Judul laporan
  final String description; // Deskripsi/kronologi kejadian
  final String location; // Lokasi kejadian
  final String status; // Status: Pending, Diproses, Selesai
  final String category; // Kategori: Pungli, Korupsi, dll

  const ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    this.status = 'Pending',
  });

  /// Buat ReportModel dari JSON response API
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    // Ambil nama kategori dari nested object kalau ada
    String catName = 'Lainnya';
    if (json['kategori'] != null && json['kategori'] is Map) {
      catName =
          json['kategori']['judul'] ?? json['kategori']['nama'] ?? 'Lainnya';
    }

    return ReportModel(
      // Pakai kode_laporan sebagai ID utama
      id:
          json['kode_laporan']?.toString() ??
          json['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['judul'] ?? '',
      description: json['deskripsi'] ?? '',
      location: json['alamat'] ?? 'Bandung',
      category: catName,
      status: json['status_tindakan'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_laporan': id,
      'judul': title,
      'deskripsi': description,
      'alamat': location,
      'category': category,
      'status_tindakan': status,
    };
  }

  @override
  List<Object> get props => [
    id,
    title,
    description,
    location,
    category,
    status,
  ];
}
