import '../../models/CastModel.dart';
import '../../models/movie_details_model.dart';

enum LoadingStatus {
  initial,
  loading,
  success,
  failure,
}

class MovieDetailsState {
  final LoadingStatus status;
  final MovieDetailsModel? movie;
  final List<CastModel> cast;
  final String? errorMessage;

  const MovieDetailsState({
    this.status = LoadingStatus.initial,
    this.movie,
    this.cast = const [],
    this.errorMessage,
  });

  MovieDetailsState copyWith({
    LoadingStatus? status,
    MovieDetailsModel? movie,
    List<CastModel>? cast,
    String? errorMessage,
  }) {
    return MovieDetailsState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      cast: cast ?? this.cast,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}