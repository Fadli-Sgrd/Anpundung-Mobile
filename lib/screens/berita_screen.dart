import 'package:flutter/material.dart';

class BeritaScreen extends StatelessWidget {
  const BeritaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data berita (ceritanya ini dapet dari API nanti)
    final List<Map<String, String>> newsData = [
      {
        "title": "Satgas Saber Pungli Bandung Amankan Oknum Parkir Liar",
        "date": "20 Des 2025",
        "image": "https://picsum.photos/id/1/400/200", // Gambar random buat contoh
        "desc": "Tim Satgas berhasil mengamankan 5 orang yang diduga melakukan pungutan liar di area alun-alun..."
      },
      {
        "title": "Sosialisasi Anti Pungli di Kelurahan Sukajadi",
        "date": "19 Des 2025",
        "image": "https://picsum.photos/id/2/400/200",
        "desc": "Warga diedukasi mengenai cara melaporkan pungli dengan aman melalui aplikasi Anpundung."
      },
      {
        "title": "Layanan Publik Bebas Pungli Jadi Target 2026",
        "date": "18 Des 2025",
        "image": "https://picsum.photos/id/3/400/200",
        "desc": "Pemkot Bandung berkomitmen membersihkan layanan administrasi dari biaya tak resmi."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Berita Terkini"),
        backgroundColor: const Color(0xFF163172), // Warna Primary
      ),
      // Pake ListView.builder biar performa aman ketika datanya ribuan 
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          final news = newsData[index];
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
                  offset: const Offset(0, 3), // Biar ada bayangan di bawah dikit
                ),
              ],
            ),
            child: Column( // Column buat numpuk gambar sama teks 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian Gambar
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    news["image"]!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // Error builder buat jaga-jaga kalau gak ada internet
                    errorBuilder: (ctx, error, stackTrace) => Container(
                      height: 150,
                      color: const Color(0xFFD6E4F0),
                      child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                    ),
                  ),
                ),
                // Bagian Teks
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news["date"]!,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
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
                        style: const TextStyle(color: Colors.black87),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, // Biar kalau kepanjangan jadi ... (titik-titik)
                      ),
                      const SizedBox(height: 10),
                      // Pake InkWell buat efek sentuh tombol "Baca" 
                      InkWell(
                        onTap: () {
                          // Nanti arahin ke detail berita di sini
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Fitur baca selengkapnya coming soon!"))
                          );
                        },
                        child: const Text(
                          "Baca Selengkapnya >",
                          style: TextStyle(color: Color(0xFF1E56A0), fontWeight: FontWeight.bold),
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
    );
  }
}