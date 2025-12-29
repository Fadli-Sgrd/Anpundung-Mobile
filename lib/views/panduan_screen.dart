import 'package:flutter/material.dart';

class PanduanScreen extends StatelessWidget {
  const PanduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> guides = [
      {"title": "Cara Membuat Laporan", "desc": "1. Buka menu 'Laporan'\n2. Klik tombol '+' atau 'Buat Laporan Baru'\n3. Isi kolom judul, lokasi, dan kronologi kejadian\n4. Pastikan data akurat untuk membantu penyelidikan\n5. Klik 'Kirim' untuk mengirimkan laporan"},
      {"title": "Keamanan Data Privasi", "desc": "• Semua laporan dienkripsi dengan teknologi terbaru\n• Identitas pelapor dijaga kerahasiaannya\n• Anda bisa melaporkan secara anonim\n• Data Anda hanya diakses oleh tim resmi"},
      {"title": "Cara Menggunakan Aplikasi", "desc": "• Home: Dashboard ringkas informasi Anda\n• Laporan: Lihat status laporan yang sudah dibuat\n• Berita: Perkembangan terkini kasus pungli\n• Edukasi: Pelajari lebih tentang pungli\n• Profile: Kelola akun dan pengaturan"},
      {"title": "Dokumen & Bukti", "desc": "Saat membuat laporan, sebaiknya sertakan:\n• Foto bukti atau lokasi kejadian\n• Waktu dan tanggal kejadian\n• Identitas pelaku (jika ada)\n• Jumlah uang yang diminta (jika ada)"},
      {"title": "Jika Ada Masalah Teknis", "desc": "• Pastikan koneksi internet stabil\n• Coba hapus cache aplikasi\n• Perbarui aplikasi ke versi terbaru\n• Hubungi admin melalui menu Bantuan"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(title: const Text("Panduan Pengguna", style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: const Color(0xFF163172), elevation: 0, centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            width: double.infinity, padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E56A0), Color(0xFF163172)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20)),
            child: const Column(children: [Icon(Icons.help_outline_rounded, color: Colors.white, size: 50), SizedBox(height: 10), Text("Panduan Lengkap Aplikasi Anpundung", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 8), Text("Temukan jawaban atas pertanyaan Anda di sini", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12))]),
          ),
          const SizedBox(height: 25),
          ...guides.map((guide) => Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(guide["title"]!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF163172))),
                leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E56A0).withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.info_outline, color: Color(0xFF1E56A0), size: 20)),
                children: [Padding(padding: const EdgeInsets.all(16.0), child: Text(guide["desc"]!, style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.6)))],
              ),
            ),
          )),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: const Color(0xFFFFF3CD), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFFFDC87), width: 1)),
            child: Row(children: [const Icon(Icons.lightbulb_outline, color: Color(0xFFCC9C00), size: 24), const SizedBox(width: 12), Expanded(child: Text("Masih punya pertanyaan? Hubungi admin melalui menu Bantuan", style: TextStyle(color: Colors.grey[800], fontSize: 12, fontWeight: FontWeight.w500)))]),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
