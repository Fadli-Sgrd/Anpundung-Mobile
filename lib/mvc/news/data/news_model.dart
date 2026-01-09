/// ==========================================================
/// FILE: news_model.dart
/// DESKRIPSI: Model data untuk Berita
///
/// Model ini merepresentasikan satu artikel berita:
/// - id: ID unik berita
/// - title: Judul berita
/// - slug: URL-friendly title
/// - content: Isi berita lengkap
/// - image: URL gambar berita
/// - createdAt: Tanggal dibuat
/// - publishedAt: Tanggal dipublikasikan
/// ==========================================================

/// Model Berita - menyimpan data satu artikel berita
class NewsModel {
  final int id; // ID unik dari database
  final String title; // Judul berita
  final String slug; // URL-friendly (untuk link)
  final String content; // Isi berita lengkap
  final String? image; // URL gambar (opsional)
  final int userId; // ID penulis berita
  final DateTime createdAt; // Tanggal dibuat
  final DateTime updatedAt; // Tanggal terakhir diupdate
  final DateTime? publishedAt; // Tanggal dipublikasikan

  const NewsModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.publishedAt,
  });

  /// Buat NewsModel dari JSON response API
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      content: json['content'] as String? ?? '',
      // Prioritas: image_url dulu, baru image
      image: json['image_url'] as String? ?? json['image'] as String?,
      userId: json['user_id'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'content': content,
      'image': image,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
