import 'package:flutter/material.dart';

class BeritaDetailScreen extends StatefulWidget {
  final String title;
  final String date;
  final String image;
  final String description;

  const BeritaDetailScreen({
    super.key,
    required this.title,
    required this.date,
    required this.image,
    required this.description,
  });

  @override
  State<BeritaDetailScreen> createState() => _BeritaDetailScreenState();
}

class _BeritaDetailScreenState extends State<BeritaDetailScreen> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Berita"),
        backgroundColor: const Color(0xFF163172),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              color: isBookmarked ? Colors.orange : Colors.white,
            ),
            onPressed: () {
              setState(() => isBookmarked = !isBookmarked);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBookmarked ? "Ditambahkan ke tersimpan" : "Dihapus dari tersimpan"),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar berita
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.network(
                widget.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, stackTrace) => Container(
                  height: 250,
                  color: const Color(0xFFD6E4F0),
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                  ),
                ),
              ),
            ),
            // Konten detail
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tanggal
                  Text(
                    widget.date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Judul
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF163172),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Garis pemisah
                  Container(
                    height: 2,
                    color: const Color(0xFF1E56A0),
                  ),
                  const SizedBox(height: 16),
                  // Konten lengkap
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Tombol share (opsional)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E56A0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.share, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "Bagikan Berita",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
