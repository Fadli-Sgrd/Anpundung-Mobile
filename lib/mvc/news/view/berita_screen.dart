import 'package:flutter/material.dart';
import '../../../data/saved_news_store.dart';
import 'berita_detail_screen.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({super.key});

  @override
  State<BeritaScreen> createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen> {
  String searchQuery = "";
  String selectedTab = "Trending";

  final List<Map<String, dynamic>> newsData = [
    {
      "username": "Onic Kairi",
      "avatar": "https://i.pravatar.cc/150?img=3",
      "time": "3m ago",
      "title": "Satgas Saber Pungli Bandung Amankan Oknum Parkir Liar",
      "content":
          "Hati-hati guys, barusan di area Malioboro, Jogja, ada kejadian klitih sekitar jam 12 malam. Katanya mereka bawa sajam dan nyerang orang yang lewat.",
      "image": "https://picsum.photos/id/1/400/200",
      "likes": 215,
      "comments": 11,
      "views": 5874,
      "category": "Trending",
    },
    {
      "username": "Itachi Uchiha",
      "avatar": "https://i.pravatar.cc/150?img=5",
      "time": "5m ago",
      "title": "Sosialisasi Anti Pungli di Kelurahan Sukajadi",
      "content":
          "Warga diedukasi mengenai cara melaporkan pungli dengan aman melalui aplikasi Anpundung. Mari jaga lingkungan kita bersama!",
      "image": "https://picsum.photos/id/2/400/200",
      "likes": 142,
      "comments": 8,
      "views": 3291,
      "category": "Bandung",
    },
    {
      "username": "Admin Anpundung",
      "avatar": "https://i.pravatar.cc/150?img=7",
      "time": "10m ago",
      "title": "Layanan Publik Bebas Pungli Jadi Target 2026",
      "content":
          "Pemkot Bandung berkomitmen membersihkan layanan administrasi dari biaya tak resmi. Target tercapai di tahun 2026!",
      "image": "https://picsum.photos/id/3/400/200",
      "likes": 89,
      "comments": 5,
      "views": 1520,
      "category": "Trending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = newsData.where((news) {
      final matchesTab =
          selectedTab == "Trending" ||
          selectedTab == "Beritaku" ||
          news["category"] == selectedTab;
      final matchesSearch =
          news["title"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          news["content"]!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesTab && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          // Header dengan Gradient + ROUNDED BOTTOM
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF163172), Color(0xFF1E56A0)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 12),
                  child: Row(
                    children: [
                      if (Navigator.canPop(context))
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      const Text(
                        "Berita Hari Ini",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Search Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      onChanged: (val) => setState(() => searchQuery = val),
                      decoration: InputDecoration(
                        hintText: "Cari Postingan atau keluhan",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab Filters - CENTERED
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["Trending", "Bandung", "Beritaku"].map((tab) {
                final isSelected = selectedTab == tab;
                return GestureDetector(
                  onTap: () => setState(() => selectedTab = tab),
                  child: Column(
                    children: [
                      Text(
                        tab,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF1E56A0)
                              : Colors.grey[600],
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 3,
                        width: 50,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF1E56A0)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Content - Posts
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
                    padding: EdgeInsets.zero,
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final news = filtered[index];
                      final isSaved = SavedNewsStore.getAll().any(
                        (e) => e['title'] == news['title'],
                      );
                      return _buildPostCard(news, isSaved);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> news, bool isSaved) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(news["avatar"]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news["username"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Posted ${news["time"]}",
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Content Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              news["content"],
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Image dengan PADDING dan ROUNDED
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeritaDetailScreen(
                      title: news["title"]!,
                      date: news["time"]!,
                      image: news["image"]!,
                      description: news["content"]!,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  news["image"],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error, stackTrace) => Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6E4F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                _buildActionButton(
                  Icons.favorite,
                  "${news["likes"]}",
                  Colors.red,
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  Icons.chat_bubble_outline,
                  "${news["comments"]}",
                  Colors.grey,
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  Icons.visibility_outlined,
                  "${news["views"]}",
                  Colors.grey,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (!isSaved) {
                      SavedNewsStore.add({
                        'title': news['title']!,
                        'date': news['time']!,
                        'image': news['image']!,
                        'desc': news['content']!,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berita disimpan')),
                      );
                    } else {
                      SavedNewsStore.removeByTitle(news['title']!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Berita dihapus dari tersimpan'),
                        ),
                      );
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          size: 18,
                          color: isSaved
                              ? const Color(0xFF1E56A0)
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Simpan",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 5),
          Text(count, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ],
      ),
    );
  }
}
