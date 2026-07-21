import '../../../../core/utils/helper.dart';
import '../../models/CastModel.dart';
import '../../models/movie_details_model.dart';



class MovieDetailsState {
  final LoadingStatus status;
  final MovieDetailsModel? movie;
  final CastModel? cast;
  final String? errorMessage;

  const MovieDetailsState({
    this.status = LoadingStatus.initial,
    this.movie,
    this.cast  ,
    this.errorMessage,
  });

  MovieDetailsState copyWith({
    LoadingStatus? status,
    MovieDetailsModel? movie,
    CastModel? cast,
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