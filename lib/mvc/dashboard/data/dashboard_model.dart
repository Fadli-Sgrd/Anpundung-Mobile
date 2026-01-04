class DashboardModel {
  final int totalLaporan;
  final int statusPending;
  final int statusProses;
  final int statusSelesai;

  const DashboardModel({
    required this.totalLaporan,
    required this.statusPending,
    required this.statusProses,
    required this.statusSelesai,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalLaporan: json['total_laporan'] as int? ?? 0,
      statusPending: json['status_pending'] as int? ?? 0,
      statusProses: json['status_proses'] as int? ?? 0,
      statusSelesai: json['status_selesai'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_laporan': totalLaporan,
      'status_pending': statusPending,
      'status_proses': statusProses,
      'status_selesai': statusSelesai,
    };
  }
}
