/// ==========================================================
/// FILE: kategori_cubit.dart
/// DESKRIPSI: State management untuk Kategori Laporan
///
/// Cubit ini mengatur daftar kategori yang tersedia untuk
/// dipilih saat membuat laporan (Pungli, Korupsi, dll)
///
/// Data kategori diambil dari API: GET /api/kategori
/// ==========================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../data/kategori_model.dart';
import '../data/kategori_repository.dart';

// ====================================
// DEFINISI STATE
// ====================================

/// Base class untuk semua state kategori
sealed class KategoriState {}

/// State awal - belum ada aksi
class KategoriInitial extends KategoriState {}

/// State loading - sedang mengambil data dari API
class KategoriLoading extends KategoriState {}

/// State loaded - data kategori berhasil dimuat
class KategoriLoaded extends KategoriState {
  final List<KategoriModel> kategoris; // Daftar kategori
  KategoriLoaded(this.kategoris);
}

/// State error - gagal mengambil data
class KategoriError extends KategoriState {
  final String message; // Pesan error
  KategoriError(this.message);
}

// ====================================
// CUBIT CLASS
// ====================================

/// Cubit untuk mengelola daftar kategori laporan
///
/// Contoh penggunaan:
/// ```dart
/// final cubit = KategoriCubit();
/// cubit.loadKategori();
/// ```
class KategoriCubit extends Cubit<KategoriState> {
  final KategoriRepository _repository;

  /// Constructor - bisa inject repository sendiri atau pakai default
  KategoriCubit({KategoriRepository? repository})
    : _repository = repository ?? KategoriRepository(),
      super(KategoriInitial());

  /// Muat daftar kategori dari API
  ///
  /// Flow:
  /// 1. Emit loading
  /// 2. Panggil API via repository
  /// 3. Emit loaded atau error
  Future<void> loadKategori() async {
    debugPrint('📤 [KategoriCubit] Memuat kategori...');
    emit(KategoriLoading());

    try {
      final kategoris = await _repository.getKategori();

      if (kategoris.isNotEmpty) {
        debugPrint(
          '✅ [KategoriCubit] Berhasil muat ${kategoris.length} kategori',
        );
        emit(KategoriLoaded(kategoris));
      } else {
        debugPrint('⚠️ [KategoriCubit] Tidak ada kategori');
        emit(KategoriError('Tidak ada kategori tersedia'));
      }
    } catch (e) {
      debugPrint('❌ [KategoriCubit] Error: $e');
      emit(KategoriError('Gagal memuat kategori'));
    }
  }
}
