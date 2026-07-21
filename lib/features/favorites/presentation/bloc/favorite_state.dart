import 'package:movies_explorer/features/favorites/data/models/favorite_movie_model.dart';

class FavoriteState {
  final List<FavoriteMovieModel> favorites;

  const FavoriteState({
    this.favorites = const [],
  });

  FavoriteState copyWith({
    List<FavoriteMovieModel>? favorites,
  }) {
    return FavoriteState(
      favorites:
      favorites ?? this.favorites,
    );
  }
}