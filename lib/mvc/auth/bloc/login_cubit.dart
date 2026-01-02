import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/auth_repository.dart';
import '../data/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  // Dependency Injection via Constructor (Modul 12)
  LoginCubit(this._authRepository) : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      final user = await _authRepository.login(email, password);
      // Logic Post-Login bisa disini (simpan data user dll)
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
