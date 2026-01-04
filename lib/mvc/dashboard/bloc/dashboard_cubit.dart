import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/dashboard_model.dart';
import '../data/dashboard_repository.dart';

// ====================================
// STATES
// ====================================

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final DashboardModel dashboard;

  const DashboardLoaded(this.dashboard);

  @override
  List<Object?> get props => [dashboard];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

// ====================================
// CUBIT
// ====================================

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _repository;

  DashboardCubit(this._repository) : super(const DashboardInitial());

  Future<void> loadDashboard() async {
    emit(const DashboardLoading());
    try {
      final dashboard = await _repository.getDashboard();
      emit(DashboardLoaded(dashboard));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }
}
