/// ==========================================================
/// FILE: login_cubit.dart
/// DESKRIPSI: State management untuk proses Login
///
/// Cubit ini mengatur kondisi (state) saat user login:
/// - LoginInitial: Belum login
/// - LoginLoading: Sedang proses login
/// - LoginSuccess: Login berhasil
/// - LoginFailure: Login gagal
/// ==========================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/auth_repository.dart';
import '../data/user_model.dart';

part 'login_state.dart';

/// Cubit untuk mengelola proses login
///
/// Contoh penggunaan di UI:
/// ```dart
/// context.read<LoginCubit>().login(email, password);
/// ```
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  /// Constructor - terima repository via parameter (Dependency Injection)
  LoginCubit(this._authRepository) : super(LoginInitial());

  /// Proses login dengan email dan password
  ///
  /// Flow:
  /// 1. Emit loading state
  /// 2. Panggil API login via repository
  /// 3. Kalau sukses, emit success dengan data user
  /// 4. Kalau gagal, emit failure dengan pesan error
  void login(String email, String password) async {
    emit(LoginLoading()); // Tampilkan loading

    try {
      // Panggil API login
      final user = await _authRepository.login(email, password);

      // Login berhasil!
      emit(LoginSuccess(user));
    } catch (e) {
      // Login gagal - tampilkan error
      emit(LoginFailure(e.toString()));
    }
  }
}
