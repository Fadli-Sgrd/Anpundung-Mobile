import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/auth_repository.dart';
import '../data/user_model.dart';

// ====================================
// STATES
// ====================================

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final UserModel user;
  
  const RegisterSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class RegisterFailure extends RegisterState {
  final String message;
  final Map<String, dynamic> errors;
  
  const RegisterFailure({
    required this.message,
    this.errors = const {},
  });

  @override
  List<Object?> get props => [message, errors];
}

// ====================================
// CUBIT
// ====================================

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(const RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoading());
    
    try {
      final user = await _authRepository.register(name, email, password);
      emit(RegisterSuccess(user));
    } on RegisterException catch (e) {
      emit(RegisterFailure(
        message: e.message,
        errors: e.errors,
      ));
    } catch (e) {
      emit(RegisterFailure(
        message: e.toString(),
      ));
    }
  }
}
