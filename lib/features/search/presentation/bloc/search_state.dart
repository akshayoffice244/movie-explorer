import '../../../../core/utils/helper.dart';
import '../../../movie/data/models/movie_response.dart';

class SearchState {
  final LoadingStatus status;

  final List<Results> movies;

  final List<String> recentSearches;

  final String? errorMessage;

  const SearchState({
    this.status = LoadingStatus.initial,
    this.movies = const [],
    this.recentSearches = const [],
    this.errorMessage,
  });

  SearchState copyWith({
    LoadingStatus? status,
    List<Results>? movies,
    List<String>? recentSearches,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      recentSearches:
      recentSearches ?? this.recentSearches,
      errorMessage:
      errorMessage ?? this.errorMessage,
    );
  }
}