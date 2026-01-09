import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../data/kontak_model.dart';
import '../data/kontak_repository.dart';

/// State untuk KontakCubit
///
/// Menggunakan sealed class pattern untuk type-safe state handling
///
/// States:
/// - KontakInitial: State awal sebelum ada aksi
/// - KontakLoading: Sedang mengirim pesan ke server
/// - KontakSuccess: Pesan berhasil dikirim
/// - KontakError: Terjadi error saat mengirim pesan
sealed class KontakState {}

/// State awal - form belum disubmit
class KontakInitial extends KontakState {}

/// State loading - sedang mengirim ke API
class KontakLoading extends KontakState {}

/// State sukses - pesan terkirim
///
/// [message] berisi pesan sukses dari backend untuk ditampilkan ke user
class KontakSuccess extends KontakState {
  final String message;
  KontakSuccess(this.message);
}

/// State error - gagal mengirim pesan
///
/// [error] berisi pesan error untuk ditampilkan ke user
class KontakError extends KontakState {
  final String error;
  KontakError(this.error);
}

/// Cubit untuk mengelola state pengiriman pesan kontak
///
/// Pattern: BLoC/Cubit Pattern untuk state management
///
/// Flow:
/// 1. User isi form → kirimPesan() dipanggil
/// 2. State berubah ke KontakLoading → UI tampilkan loading
/// 3. Repository mengirim ke API
/// 4. Sukses → KontakSuccess → UI tampilkan sukses
/// 5. Gagal → KontakError → UI tampilkan error
class KontakCubit extends Cubit<KontakState> {
  final KontakRepository _repository;

  /// Constructor dengan dependency injection
  ///
  /// [repository] bisa di-inject untuk testing
  /// Jika tidak disediakan, akan buat instance baru
  KontakCubit({KontakRepository? repository})
    : _repository = repository ?? KontakRepository(),
      super(KontakInitial());

  /// Mengirim pesan kontak ke server
  ///
  /// Melakukan validasi sederhana di sisi client sebelum
  /// mengirim ke server untuk UX yang lebih baik
  ///
  /// Parameters:
  /// - [nama]: Nama pengirim
  /// - [email]: Email pengirim (untuk reply)
  /// - [subject]: Subjek/topik pesan
  /// - [message]: Isi pesan
  Future<void> kirimPesan({
    required String nama,
    required String email,
    required String subject,
    required String message,
  }) async {
    debugPrint('📤 [KontakCubit] Memproses pengiriman pesan...');

    // Validasi client-side untuk immediate feedback
    // Validasi server-side tetap dilakukan di backend (defense in depth)
    if (nama.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
      debugPrint('❌ [KontakCubit] Validasi gagal - field kosong');
      emit(KontakError('Semua field harus diisi'));
      return;
    }

    // Validasi format email sederhana
    if (!_isValidEmail(email)) {
      debugPrint('❌ [KontakCubit] Validasi gagal - email tidak valid');
      emit(KontakError('Format email tidak valid'));
      return;
    }

    // Emit loading state
    emit(KontakLoading());

    // Buat model kontak
    final kontak = KontakModel(
      nama: nama,
      email: email,
      subject: subject,
      message: message,
    );

    // Kirim ke repository
    final result = await _repository.kirimPesan(kontak);

    // Handle result
    if (result['success'] == true) {
      debugPrint('✅ [KontakCubit] Pesan berhasil dikirim');
      emit(KontakSuccess(result['message']));
    } else {
      debugPrint('❌ [KontakCubit] Gagal: ${result['message']}');
      emit(KontakError(result['message']));
    }
  }

  /// Reset state ke initial
  ///
  /// Dipanggil saat user ingin mengirim pesan baru
  /// setelah sukses/error sebelumnya
  void reset() {
    emit(KontakInitial());
  }

  /// Validasi format email sederhana
  ///
  /// Menggunakan regex dasar untuk validasi email
  /// Validasi lebih ketat dilakukan di server
  bool _isValidEmail(String email) {
    // Regex untuk validasi email dasar
    // Format: xxx@xxx.xxx
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
