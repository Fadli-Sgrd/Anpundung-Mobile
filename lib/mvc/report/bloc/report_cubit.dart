/// ==========================================================
/// FILE: report_cubit.dart
/// DESKRIPSI: State management untuk fitur Laporan
///
/// Cubit ini mengatur kondisi (state) untuk:
/// - Memuat daftar laporan user
/// - Menambah laporan baru
/// - Menghapus laporan
///
/// States yang tersedia:
/// - ReportInitial: Belum ada aksi
/// - ReportLoading: Sedang memuat data
/// - ReportLoaded: Data berhasil dimuat
/// - ReportError: Terjadi error
/// ==========================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/report_model.dart';
import '../data/report_repository.dart';

// ====================================
// DEFINISI STATE
// Semua kondisi yang mungkin terjadi
// ====================================

/// Base class untuk semua state laporan
abstract class ReportState extends Equatable {
  const ReportState();
  @override
  List<Object> get props => [];
}

/// State awal - belum ada aksi apapun
class ReportInitial extends ReportState {}

/// State loading - sedang mengambil/mengirim data
class ReportLoading extends ReportState {}

/// State loaded - data laporan berhasil dimuat
class ReportLoaded extends ReportState {
  final List<ReportModel> reports; // Daftar laporan
  const ReportLoaded(this.reports);
  @override
  List<Object> get props => [reports];
}

/// State error - terjadi kesalahan
class ReportError extends ReportState {
  final String message; // Pesan error
  const ReportError(this.message);
  @override
  List<Object> get props => [message];
}

// ====================================
// CUBIT CLASS
// Pengatur state laporan
// ====================================

/// Cubit untuk mengelola state laporan
///
/// Contoh penggunaan:
/// ```dart
/// // Muat semua laporan
/// context.read<ReportCubit>().loadReports();
///
/// // Tambah laporan baru
/// context.read<ReportCubit>().addReport(title, desc, loc, cat, date);
/// ```
class ReportCubit extends Cubit<ReportState> {
  final ReportRepository _repository;

  ReportCubit(this._repository) : super(ReportInitial());

  /// Muat semua laporan user dari API
  void loadReports() async {
    emit(ReportLoading()); // Tampilkan loading
    try {
      final reports = await _repository.getReports();
      emit(ReportLoaded(reports)); // Sukses!
    } catch (e) {
      emit(ReportError(e.toString())); // Gagal
    }
  }

  /// Tambah laporan baru
  ///
  /// Parameters:
  /// - title: Judul laporan
  /// - desc: Deskripsi/kronologi
  /// - loc: Lokasi kejadian
  /// - category: Kategori (Pungli, Korupsi, dll)
  /// - date: Tanggal kejadian
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

      // Reload data terbaru setelah berhasil
      loadReports();
    } catch (e) {
      emit(ReportError("Gagal menambah laporan: $e"));
    }
  }

  /// Hapus laporan berdasarkan ID
  Future<void> deleteReport(String id) async {
    try {
      await _repository.deleteReport(id);

      // Update list tanpa harus reload dari API
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
