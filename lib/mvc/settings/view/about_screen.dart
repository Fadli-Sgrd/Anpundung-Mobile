import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          "Tentang Aplikasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF163172),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E56A0), Color(0xFF163172)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset(
                      'assets/images/logo-anpundung.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.shield_outlined,
                          color: Color(0xFF163172),
                          size: 50,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Anpundung",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Anti Pungutan Liar Bandung",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Versi 1.0.0",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tentang Aplikasi",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF163172),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Anpundung adalah aplikasi mobile yang dirancang untuk memberantas pungutan liar (pungli) di Kota Bandung. Aplikasi ini memungkinkan masyarakat melaporkan kejadian pungli dengan aman dan anonim, serta membantu pemerintah dalam menindaklanjuti laporan secara cepat dan transparan.\n\nMisi kami adalah menciptakan layanan publik yang bebas dari pungli dan terlindungi sepenuhnya.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fitur Utama",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF163172),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFeatureItem(
                    "📝",
                    "Laporan Anonim",
                    "Laporkan pungli dengan identitas terlindungi",
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    "📰",
                    "Berita Terkini",
                    "Update berita tentang pemberantasan pungli",
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    "📚",
                    "Pojok Edukasi",
                    "Pelajari lebih lanjut tentang pungli",
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    "🔔",
                    "Tracking Status",
                    "Pantau perkembangan laporan Anda",
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    "📞",
                    "Nomor Darurat",
                    "Akses kontak darurat yang tersedia",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tim Pengembang",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF163172),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildDeveloperItem("👨‍💻", "Ketua Tim", "Jajang Gunawan"),
                  const SizedBox(height: 10),
                  _buildDeveloperItem(
                    "👩‍💻",
                    "Developer",
                    "Tim Development Bandung",
                  ),
                  const SizedBox(height: 10),
                  _buildDeveloperItem(
                    "🏢",
                    "Institusi",
                    "Pemerintah Kota Bandung",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "© 2025 Pemerintah Kota Bandung\nSemua Hak Dilindungi",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String emoji, String title, String subtitle) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeveloperItem(String emoji, String role, String name) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              role,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
