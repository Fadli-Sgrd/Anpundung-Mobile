import 'package:flutter/material.dart';

class BantuanScreen extends StatelessWidget {
  const BantuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        "question": "Bagaimana cara membuat laporan pungli?",
        "answer": "Buka menu 'Laporan', klik tombol '+' atau 'Buat Laporan Baru'. Isi kolom judul, lokasi, dan kronologi kejadian dengan detail. Pastikan informasi akurat agar membantu penyelidikan. Klik 'Kirim' untuk mengirimkan laporan."
      },
      {
        "question": "Apakah identitas saya aman?",
        "answer": "Ya, semua laporan dijaga kerahasiaannya. Anda bisa melaporkan secara anonim. Sistem enkripsi kami menjamin data Anda tidak diakses oleh pihak yang tidak berwenang."
      },
      {
        "question": "Berapa lama proses penyelidikan?",
        "answer": "Waktu penyelidikan tergantung kompleksitas kasus, biasanya 2-4 minggu. Anda bisa memantau perkembangan laporan di menu 'Riwayat Aktivitas' dengan update status real-time."
      },
      {
        "question": "Apa saja jenis pungli yang bisa dilaporkan?",
        "answer": "Semua jenis pungutan liar bisa dilaporkan: pungli layanan publik (KTP, SIM), parkir liar, sekolah, perizinan usaha, dan lainnya. Jika ragu, silakan hubungi admin kami."
      },
      {
        "question": "Bagaimana jika saya lupa password?",
        "answer": "Anda bisa reset password melalui menu 'Edit Profil' atau 'Pengaturan Akun'. Pilih 'Lupa Password' dan ikuti instruksi yang dikirim ke email Anda."
      },
      {
        "question": "Bisa upload bukti foto saat melaporkan?",
        "answer": "Iya, fitur upload foto sedang dikembangkan. Dalam waktu dekat Anda bisa menambahkan multiple foto sebagai bukti laporan."
      },
      {
        "question": "Apakah ada dampak hukum bagi saya jika melapor?",
        "answer": "Tidak ada. Pelapor dilindungi oleh undang-undang. Lembaga Perlindungan Saksi (LPSK) siap melindungi kesaksian Anda jika diperlukan."
      },
      {
        "question": "Bisa berkomunikasi langsung dengan admin?",
        "answer": "Tentu! Scroll ke bawah halaman ini dan isi form 'Hubungi Kami'. Admin kami akan merespons dalam 24 jam."
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Bantuan & FAQ", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF163172),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E56A0), Color(0xFF163172)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(Icons.help_center, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Pusat Bantuan & FAQ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Temukan jawaban atas pertanyaan Anda",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // FAQ List
            const Text(
              "Pertanyaan Umum",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),
            ...List.generate(
              faqs.length,
              (index) {
                final faq = faqs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        faq["question"]!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF163172),
                        ),
                      ),
                      leading: const Icon(Icons.help_outline, color: Color(0xFF1E56A0), size: 20),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            faq["answer"]!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // Hubungi Kami Section
            const Text(
              "Hubungi Kami",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 15),
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
                    "Isi form di bawah dan tim kami akan merespons dalam 24 jam",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nama Anda",
                      prefixIcon: const Icon(Icons.person, color: Color(0xFF1E56A0)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email, color: Color(0xFF1E56A0)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Pesan",
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.message, color: Color(0xFF1E56A0)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E56A0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Pesan Anda telah terkirim!")),
                        );
                      },
                      child: const Text(
                        "Kirim Pesan",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
