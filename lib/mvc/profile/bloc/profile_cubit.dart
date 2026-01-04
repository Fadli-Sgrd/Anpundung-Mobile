import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/profile_model.dart';
import '../data/profile_repository.dart';

// ====================================
// STATES
// ====================================

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdating extends ProfileState {
  const ProfileUpdating();
}

class ProfileUpdated extends ProfileState {
  final ProfileModel profile;

  const ProfileUpdated(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

// ====================================
// CUBIT
// ====================================

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileInitial());

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    try {
      final profile = await _repository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? city,
  }) async {
    emit(const ProfileUpdating());
    try {
      final profile = await _repository.updateProfile(
        name: name,
        email: email,
        phone: phone,
        address: address,
        city: city,
      );
      emit(ProfileUpdated(profile));
      // Reload profile untuk consistency
      await loadProfile();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> refreshProfile() async {
    await loadProfile();
  }
}
