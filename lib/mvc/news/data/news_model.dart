class NewsModel {
  final int id;
  final String title;
  final String slug;
  final String content;
  final String? image;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NewsModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      content: json['content'] as String? ?? '',
      image: json['image'] as String?,
      userId: json['user_id'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
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
