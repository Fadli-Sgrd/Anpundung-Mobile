import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Pastikan path import ini sesuai sama struktur folder kamu ya
import '../cubit/report_cubit.dart'; 
import '../models/report_model.dart';
import 'laporan_detail_screen.dart';

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  List<String> selectedPhotos = []; // Untuk nyimpen foto yang dipilih

  // --- FUNGSI: TAMPILKAN FORM TAMBAH LAPORAN ---
 
  void _showAddReportForm(BuildContext context) {
    // Controller buat nyimpen teks yang diketik user
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final locController = TextEditingController();
    List<String> formPhotos = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Biar pas keyboard muncul, form-nya naik ke atas (gak ketutup)
      backgroundColor: Colors.transparent, // Transparan biar kita bisa bikin rounded corner sendiri
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20, // Jarak biar gak nempel keyboard
            top: 25,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)), // Sudut atas melengkung
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ukurannya ngikutin isi konten aja
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Form
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Buat Laporan Baru",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF163172)),
                ),
                const Text("Identitas pelapor akan disamarkan (Anonim).", style: TextStyle(color: Colors.grey)),
                
                const SizedBox(height: 25),

                // Input Judul
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Judul Pungli",
                    prefixIcon: const Icon(Icons.title, color: Color(0xFF1E56A0)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                  ),
                ),
                const SizedBox(height: 15),

                // Input Lokasi
                TextField(
                  controller: locController,
                  decoration: InputDecoration(
                    labelText: "Lokasi Kejadian",
                    prefixIcon: const Icon(Icons.location_on, color: Color(0xFF1E56A0)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                  ),
                ),
                const SizedBox(height: 15),

                // Input Kronologi
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Kronologi Singkat",
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.description, color: Color(0xFF1E56A0)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                  ),
                ),
                const SizedBox(height: 15),

                // Upload Foto Section
                const Text(
                  "Upload Bukti Foto (Opsional)",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF163172)),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Simulasi upload foto
                    setState(() {
                      formPhotos.add("https://picsum.photos/200/300?random=${DateTime.now().millisecondsSinceEpoch}");
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD6E4F0), width: 2),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFF6F6F6),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.cloud_upload_outlined, color: Color(0xFF1E56A0), size: 40),
                        const SizedBox(height: 8),
                        const Text(
                          "Tap untuk tambah foto",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF1E56A0)),
                        ),
                        Text(
                          "${formPhotos.length} foto dipilih",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                if (formPhotos.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: formPhotos.length,
                      itemBuilder: (ctx, idx) => Stack(
                        children: [
                          Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(formPhotos[idx]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => setState(() => formPhotos.removeAt(idx)),
                              child: Container(
                                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                child: const Icon(Icons.close, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 25),

                // Tombol Kirim
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF163172), // Warna Primary
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  shadowColor: const Color(0x40163172),
                ),
                onPressed: () {
                  // Validasi simpel: kalau kosong jangan dikirim
                  if (titleController.text.isEmpty || descController.text.isEmpty) {
                    return;
                  }

                  
                  context.read<ReportCubit>().addReport(
                    titleController.text,
                    descController.text,
                    locController.text,
                  );
                  
                  Navigator.pop(ctx); // Tutup form

                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 10),
                          Text("Laporan berhasil dikirim!"),
                        ],
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    )
                  );
                },
                child: const Text(
                  "KIRIM LAPORAN SEKARANG",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6), // Background abu sangat muda biar konten pop-up
      appBar: AppBar(
        title: const Text("Laporan Saya", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF163172),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)) // Ikon hiasan aja
        ],
      ),
      
      // Tombol Tambah (Floating Action Button) yang melayang [cite: 146]
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF1E56A0),
        onPressed: () => _showAddReportForm(context),
        elevation: 4,
        icon: const Icon(Icons.add_moderator, color: Colors.white), // Ikon Tameng +
        label: const Text("Lapor Pungli", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),

      // --- BODY UTAMA: LIST LAPORAN ---
      // Pake BlocBuilder buat dengerin perubahan data dari Cubit [cite: 146, 196]
      body: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          // KONDISI 1: Kalau data ada isinya
          if (state is ReportLoaded && state.reports.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 80), // Padding bawah gede biar gak ketutup FAB
              itemCount: state.reports.length, // Jumlah item sesuai data state
              itemBuilder: (context, index) {
                final report = state.reports[index];
                return _buildReportCard(context, report); // Panggil fungsi widget kartu
              },
            );
          }
          
          // KONDISI 2: Kalau data kosong (Empty State)
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 20, spreadRadius: 5)],
                  ),
                  child: const Icon(Icons.folder_open_rounded, size: 60, color: Color(0xFFD6E4F0)),
                ),
                const SizedBox(height: 20),
                Text(
                  "Belum ada laporan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                ),
                const SizedBox(height: 5),
                Text(
                  "Ayo bantu berantas pungli di Bandung!",
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- WIDGET KARTU LAPORAN YANG "WOW" ---
  // Kita pisahin di sini biar kodingan di atas gak pusing bacanya
  Widget _buildReportCard(BuildContext context, ReportModel report) {
    // Tentukan warna badge status biar dinamis
    Color statusColor;
    Color statusBg;

    if (report.status == 'Selesai') {
      statusColor = Colors.green;
      statusBg = Colors.green[50]!;
    } else if (report.status == 'Diproses') {
      statusColor = Colors.orange;
      statusBg = Colors.orange[50]!;
    } else {
      statusColor = const Color(0xFF1E56A0); // Biru
      statusBg = const Color(0xFFD6E4F0);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Jarak antar kartu
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Sudut tumpul modern
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Bayangan halus
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          // 1. Header Kartu (Status & Tanggal)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA), // Abu sangat muda
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Badge Status
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: statusColor),
                      const SizedBox(width: 6),
                      Text(
                        report.status,
                        style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                // Tanggal (Dummy)
                Text("20 Des 2025", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              ],
            ),
          ),

          // 2. Isi Konten Laporan
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul
                Text(
                  report.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF163172)),
                ),
                const SizedBox(height: 8),
                // Lokasi
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(report.location, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 12),
                // Deskripsi
                Text(
                  report.description,
                  style: const TextStyle(color: Colors.black54, height: 1.5),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // 3. Tombol Aksi (Hapus & Detail)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => LaporanDetailScreen(report: report),
                        ),
                      );
                    },
                    icon: const Icon(Icons.visibility_outlined, size: 18),
                    label: const Text("Lihat Detail"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E56A0),
                      side: const BorderSide(color: Color(0xFF1E56A0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Tombol Hapus (Delete)
                Container(
                  decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                    
                    onPressed: () => context.read<ReportCubit>().deleteReport(report.id),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: "Hapus Laporan",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}