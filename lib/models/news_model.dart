/// Model untuk data berita
class NewsModel {
  final String title;
  final String date;
  final String image;
  final String description;

  const NewsModel({
    required this.title,
    required this.date,
    required this.image,
    required this.description,
  });

  /// Convert dari Map ke NewsModel
  factory NewsModel.fromMap(Map<String, String> map) {
    return NewsModel(
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      image: map['image'] ?? '',
      description: map['desc'] ?? map['description'] ?? '',
    );
  }

  /// Convert ke Map
  Map<String, String> toMap() {
    return {
      'title': title,
      'date': date,
      'image': image,
      'desc': description,
    };
  }
}
