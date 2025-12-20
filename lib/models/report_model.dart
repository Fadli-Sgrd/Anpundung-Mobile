class ReportModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String status; // 'Terkirim', 'Diproses', 'Selesai'

  ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    this.status = 'Terkirim',
  });
}