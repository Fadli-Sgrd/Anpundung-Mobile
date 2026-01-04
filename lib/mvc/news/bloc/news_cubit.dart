import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/news_model.dart';
import '../data/news_repository.dart';

// ====================================
// STATES
// ====================================

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;

  const NewsLoaded(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}

// ====================================
// CUBIT
// ====================================

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository;

  NewsCubit(this._repository) : super(const NewsInitial());

  Future<void> loadNews() async {
    emit(const NewsLoading());
    try {
      final news = await _repository.getNews();
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> refreshNews() async {
    await loadNews();
  }
}
