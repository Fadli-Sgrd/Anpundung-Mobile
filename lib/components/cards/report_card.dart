import 'package:flutter/material.dart';
import '../../mvc/report/data/report_model.dart';

/// Report Card reusable (dari laporan_screen)
class ReportCard extends StatelessWidget {
  final ReportModel report;
  final VoidCallback onDetail;
  final VoidCallback onDelete;

  const ReportCard({
    super.key,
    required this.report,
    required this.onDetail,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
      statusColor = const Color(0xFF1E56A0);
      statusBg = const Color(0xFFD6E4F0);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. Header Kartu (Status & Tanggal)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Badge Status
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: statusColor),
                      const SizedBox(width: 6),
                      Text(
                        report.status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tanggal
                Text(
                  "20 Des 2025",
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF163172),
                  ),
                ),
                const SizedBox(height: 8),
                // Lokasi
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      report.location,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
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
                    onPressed: onDetail,
                    icon: const Icon(Icons.visibility_outlined, size: 18),
                    label: const Text("Lihat Detail"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E56A0),
                      side: const BorderSide(color: Color(0xFF1E56A0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Tombol Hapus (Delete)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: "Hapus Laporan",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
