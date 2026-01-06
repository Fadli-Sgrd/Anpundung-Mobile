import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/report_model.dart';
import '../data/report_repository.dart'; // Add Repository usage

// Define States here directly or in separate file (Modul 12: often separate, but simple cubit can keep it)
abstract class ReportState extends Equatable {
  const ReportState();
  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List<ReportModel> reports;
  const ReportLoaded(this.reports);
  @override
  List<Object> get props => [reports];
}

class ReportError extends ReportState {
  final String message;
  const ReportError(this.message);
  @override
  List<Object> get props => [message];
}

class ReportCubit extends Cubit<ReportState> {
  final ReportRepository _repository; // Inject Repository

  ReportCubit(this._repository) : super(ReportInitial());

  // Init Data (bisa dipanggil di UI saat screen dibuka)
  void loadReports() async {
    emit(ReportLoading());
    try {
      final reports = await _repository.getReports();
      emit(ReportLoaded(reports));
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }

  Future<void> addReport(
    String title,
    String desc,
    String loc,
    String category,
    String date,
  ) async {
    try {
      await _repository.addReport(
        title: title,
        description: desc,
        location: loc,
        date: date,
        categoryName: category,
      );

      // Reload fresh data
      loadReports();
    } catch (e) {
      emit(ReportError("Gagal nambah laporan: $e"));
    }
  }

  Future<void> deleteReport(String id) async {
    try {
      await _repository.deleteReport(id);

      if (state is ReportLoaded) {
        final currentList = (state as ReportLoaded).reports;
        final newList = currentList.where((item) => item.id != id).toList();
        emit(ReportLoaded(newList));
      }
    } catch (e) {
      emit(ReportError("Gagal menghapus laporan: $e"));
    }
  }
}
