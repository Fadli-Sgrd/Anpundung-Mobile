import 'package:equatable/equatable.dart';

class ReportModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String location;
  final String status; // Pending, Processed, Done
  final String category;

  const ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    this.status = 'Pending',
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    // Handle nested category name if available, otherwise default
    String catName = 'Lainnya';
    if (json['kategori'] != null && json['kategori'] is Map) {
      catName =
          json['kategori']['judul'] ?? json['kategori']['nama'] ?? 'Lainnya';
    }

    return ReportModel(
      // Use kode_laporan as the ID for API interactions
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
