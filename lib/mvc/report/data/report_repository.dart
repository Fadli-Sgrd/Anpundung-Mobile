// import '../../../core/dio_client.dart';
import 'report_model.dart';

class ReportRepository {
  // Simpan data di memory biar nambah beneran (selama app jalan)
  final List<ReportModel> _mockReports = [
    const ReportModel(
      id: '1',
      title: 'Jalan Bolong',
      description: 'Bahaya bang',
      location: 'Jl. Dago',
      category: 'Lainnya',
    ),
    const ReportModel(
      id: '2',
      title: 'Pungli Parkir',
      description: 'Minta 10rb',
      location: 'Alun-alun',
      category: 'Pungli',
    ),
  ];

  // Get Reports
  Future<List<ReportModel>> getReports() async {
    // Simulate latency
    await Future.delayed(const Duration(seconds: 1));
    // Return list terbaru dari memory
    return List.from(_mockReports);
  }

  // Add Report
  Future<void> addReport(ReportModel report) async {
    // Mocking latency
    await Future.delayed(const Duration(seconds: 1));
    // Masukin ke list memory
    _mockReports.add(report);
  }
}
