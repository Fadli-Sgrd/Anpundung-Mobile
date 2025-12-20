import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/report_model.dart';

// State ini buat ngasih tau UI lagi loading, ada data, atau kosong
abstract class ReportState {}
class ReportInitial extends ReportState {}
class ReportLoaded extends ReportState {
  final List<ReportModel> reports;
  ReportLoaded(this.reports);
}

class ReportCubit extends Cubit<ReportState> {
  // Awal-awal datanya kosong dulu 
  ReportCubit() : super(ReportInitial());

  // Ceritanya ini database lokal sementara (List)
  List<ReportModel> _reports = [];

  // FUNGSI CREATE (Tambah Laporan)
  void addReport(String title, String desc, String loc) {
    // Simulasi loading biar kerasa "real"
    // Di sini nanti bisa dipasang Dio.post() 
    final newReport = ReportModel(
      id: DateTime.now().toString(),
      title: title,
      description: desc,
      location: loc,
    );
    _reports.add(newReport);
    // Emit state baru biar UI update otomatis 
    emit(ReportLoaded(List.from(_reports))); 
  }

  // FUNGSI DELETE (Hapus Laporan)
  void deleteReport(String id) {
    _reports.removeWhere((item) => item.id == id);
    emit(ReportLoaded(List.from(_reports)));
  }

  // FUNGSI UPDATE (Ganti status jadi 'Selesai' misalnya)
  void markAsDone(String id) {
    // Logic update data dummy
    // Harusnya update ke server via Dio.put() 

  }
}