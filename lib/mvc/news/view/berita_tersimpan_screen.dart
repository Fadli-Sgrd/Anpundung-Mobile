import 'package:flutter/material.dart';
import '../../../data/saved_news_store.dart';
import 'berita_detail_screen.dart';

class BeritaTersimpanScreen extends StatefulWidget {
  const BeritaTersimpanScreen({super.key});

  @override
  State<BeritaTersimpanScreen> createState() => _BeritaTersimpanScreenState();
}

class _BeritaTersimpanScreenState extends State<BeritaTersimpanScreen> {
  void _removeBookmark(int index) {
    SavedNewsStore.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Berita dihapus dari tersimpan")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          "Berita Tersimpan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF163172),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ValueListenableBuilder<List<Map<String, String>>>(
        valueListenable: SavedNewsStore.saved,
        builder: (context, savedNews, _) {
          if (savedNews.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_outline,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Tidak Ada Berita Tersimpan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Bookmark berita Anda untuk menyimpannya di sini",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: savedNews.length,
            itemBuilder: (context, index) {
              final news = savedNews[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.network(
                        news["image"]!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, error, stackTrace) => Container(
                          height: 150,
                          color: const Color(0xFFD6E4F0),
                          child: const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                news["date"]!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _removeBookmark(index),
                                child: const Icon(
                                  Icons.bookmark,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            news["title"]!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF163172),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            news["desc"]!,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BeritaDetailScreen(
                                    title: news['title']!,
                                    date: news['date']!,
                                    image: news['image']!,
                                    description: news['desc']!,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Baca Selengkapnya >",
                              style: TextStyle(
                                color: Color(0xFF1E56A0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
