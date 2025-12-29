import 'package:flutter/material.dart';

class EdukasiScreen extends StatefulWidget {
  const EdukasiScreen({super.key});

  @override
  State<EdukasiScreen> createState() => _EdukasiScreenState();
}

class _EdukasiScreenState extends State<EdukasiScreen> {
  String selectedCategory = "Semua";

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> materials = [
      {"title": "Apa itu Pungli?", "desc": "Pungutan Liar (Pungli) adalah pengenaan biaya di tempat yang tidak seharusnya biaya dikenakan atau dipungut. Kegiatan ini melanggar hukum dan merugikan masyarakat.", "category": "Definisi", "icon": "question_mark"},
      {"title": "Jenis-Jenis Pungli", "desc": "1. Pungli Pelayanan Publik (KTP, SIM, Surat Tanah)\n2. Pungli Parkir Liar\n3. Pungli di Sekolah/Pendidikan\n4. Pungli Perizinan Usaha", "category": "Jenis", "icon": "list"},
      {"title": "Pasal Hukum & Sanksi", "desc": "Pelaku pungli dapat dijerat Pasal 368 KUHP dengan ancaman penjara maksimal 9 tahun. Jangan takut melapor karena hukum melindungi korban!", "category": "Hukum", "icon": "gavel"},
      {"title": "Cara Melapor Aman", "desc": "Gunakan fitur 'Laporan' di aplikasi Anpundung. Sertakan bukti foto atau lokasi. Identitasmu kami jamin kerahasiaannya (Anonim).", "category": "Tips", "icon": "shield"},
      {"title": "Proteksi Hukum Pelapor", "desc": "Undang-undang melindungi pelapor pungli. Anda tidak akan dipersalahkan atas laporan yang jujur.", "category": "Hukum", "icon": "protection"},
      {"title": "Tips Menghadapi Pungli", "desc": "1. Tetap tenang dan jangan panik\n2. Catat identitas pelaku dan saksi\n3. Dokumentasikan kejadian (foto/video)\n4. Laporkan segera ke pihak berwenang", "category": "Tips", "icon": "tips"},
    ];

    final filtered = selectedCategory == "Semua" ? materials : materials.where((m) => m["category"] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(title: const Text("Pojok Edukasi", style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: const Color(0xFF163172), elevation: 0, centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            width: double.infinity, padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E56A0), Color(0xFF163172)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))]),
            child: const Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Kenali Pungli!", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), SizedBox(height: 5), Text("Mari ciptakan Bandung bersih melayani tanpa korupsi.", style: TextStyle(color: Color(0xFFD6E4F0)))])), Icon(Icons.lightbulb_circle, size: 60, color: Colors.yellow)]),
          ),
          const SizedBox(height: 25),
          const Text("Kategori", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF163172))),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: ["Semua", "Definisi", "Jenis", "Hukum", "Tips"].map((category) => Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(onTap: () => setState(() => selectedCategory = category), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: selectedCategory == category ? const Color(0xFF1E56A0) : Colors.grey[200], borderRadius: BorderRadius.circular(20)), child: Text(category, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: selectedCategory == category ? Colors.white : Colors.grey[700])))))).toList()),
          ),
          const SizedBox(height: 25),
          const Text("Materi Penting", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF163172))),
          const SizedBox(height: 10),
          ...filtered.map((item) => Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))]),
            child: Theme(data: Theme.of(context).copyWith(dividerColor: Colors.transparent), child: ExpansionTile(
              leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFD6E4F0), borderRadius: BorderRadius.circular(10)), child: Icon(_getIcon(item['icon']!), color: const Color(0xFF163172))),
              title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF163172))),
              subtitle: Text(item['category']!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              children: [Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), child: Text(item['desc']!, style: const TextStyle(color: Colors.black54, height: 1.5)))],
            )),
          )),
        ],
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'question_mark': return Icons.help_outline_rounded;
      case 'list': return Icons.format_list_bulleted_rounded;
      case 'gavel': return Icons.gavel_rounded;
      case 'shield': return Icons.security_rounded;
      case 'protection': return Icons.verified_user_rounded;
      case 'tips': return Icons.lightbulb_rounded;
      default: return Icons.info_outline;
    }
  }
}
