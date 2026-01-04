import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/auth_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository _authRepository;

  LogoutCubit(this._authRepository) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await _authRepository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
