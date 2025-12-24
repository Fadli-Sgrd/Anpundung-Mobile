import 'package:flutter/material.dart';
import 'berita_detail_screen.dart';
import '../data/saved_news_store.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({super.key});

  @override
  State<BeritaScreen> createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  String selectedFilter = "Semua";

  @override
  Widget build(BuildContext context) {
    // Dummy data berita (ceritanya ini dapet dari API nanti)
    final List<Map<String, String>> newsDataBeritaTerkini = [
      {
        "title": "Satgas Saber Pungli Bandung Amankan Oknum Parkir Liar",
        "date": "20 Des 2025",
        "image": "https://picsum.photos/id/1/400/200",
        "desc":
            "Tim Satgas berhasil mengamankan 5 orang yang diduga melakukan pungutan liar di area alun-alun...",
      },
      {
        "title": "Sosialisasi Anti Pungli di Kelurahan Sukajadi",
        "date": "19 Des 2025",
        "image": "https://picsum.photos/id/2/400/200",
        "desc":
            "Warga diedukasi mengenai cara melaporkan pungli dengan aman melalui aplikasi Anpundung.",
      },
      {
        "title": "Layanan Publik Bebas Pungli Jadi Target 2026",
        "date": "18 Des 2025",
        "image": "https://picsum.photos/id/3/400/200",
        "desc":
            "Pemkot Bandung berkomitmen membersihkan layanan administrasi dari biaya tak resmi.",
      },
    ];

    final List<Map<String, String>> newsDataDisekitar = [
      {
        "title": "Pungli Merajalela di Terminal Bekasi",
        "date": "21 Des 2025",
        "image": "https://picsum.photos/id/4/400/200",
        "desc":
            "Masyarakat melaporkan aksi pungli oleh petugas parkir di area terminal yang sangat merugikan.",
      },
      {
        "title": "Gerakan Komunitas Lawan Pungli di Yogyakarta",
        "date": "20 Des 2025",
        "image": "https://picsum.photos/id/5/400/200",
        "desc":
            "Komunitas peduli hukum dari Yogyakarta melakukan sosialisasi mencegah pungli di kalangan UMKM.",
      },
      {
        "title": "Kasus Pungli Layanan Kesehatan Terbongkar",
        "date": "19 Des 2025",
        "image": "https://picsum.photos/id/6/400/200",
        "desc":
            "Polisi mengungkap jaringan pungli yang melibatkan oknum petugas kesehatan di Jakarta Timur.",
      },
    ];

    final List<Map<String, String>> displayedNews = selectedTabIndex == 0
        ? newsDataBeritaTerkini
        : newsDataDisekitar;

    // Filter berdasarkan search
    final filtered = displayedNews
        .where(
          (news) =>
              news["title"]!.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Berita"),
        backgroundColor: const Color(0xFF163172),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              onChanged: (val) => setState(() => searchQuery = val),
              decoration: InputDecoration(
                hintText: "Cari berita...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF1E56A0)),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => searchQuery = ""),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFD6E4F0)),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),

          // Tab Navigation (Navbar)
          Divider(height: 1, color: Colors.grey[300]),

          // Filter Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: ["Semua", "Terbaru", "Populer"].map((filter) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedFilter = filter),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selectedFilter == filter
                            ? const Color(0xFF1E56A0)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selectedFilter == filter
                              ? Colors.white
                              : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Content
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.newspaper,
                          size: 60,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Berita tidak ditemukan",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final news = filtered[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
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
                                errorBuilder: (ctx, error, stackTrace) =>
                                    Container(
                                      height: 150,
                                      color: const Color(0xFFD6E4F0),
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
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
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              final isSaved = SavedNewsStore.getAll().any((e) => e['title'] == news['title']);
                                              if (!isSaved) {
                                                SavedNewsStore.add({
                                                  'title': news['title']!,
                                                  'date': news['date']!,
                                                  'image': news['image']!,
                                                  'desc': news['desc']!,
                                                });
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berita disimpan')));
                                              } else {
                                                SavedNewsStore.removeByTitle(news['title']!);
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berita dihapus dari tersimpan')));
                                              }
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              SavedNewsStore.getAll().any((e) => e['title'] == news['title']) ? Icons.bookmark : Icons.bookmark_outline,
                                              color: SavedNewsStore.getAll().any((e) => e['title'] == news['title']) ? Colors.orange : Colors.grey,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    news["title"]!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF163172),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    news["desc"]!,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BeritaDetailScreen(
                                                title: news["title"]!,
                                                date: news["date"]!,
                                                image: news["image"]!,
                                                description: news["desc"]!,
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
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? const Color(0xFF1E56A0) : Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          if (isActive)
            Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1E56A0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}
