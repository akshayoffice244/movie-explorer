import 'package:movies_explorer/features/favorites/data/models/favorite_movie_model.dart';

abstract class FavoriteEvent {
  const FavoriteEvent();
}

class LoadFavorites
    extends FavoriteEvent {}

class AddFavorite
    extends FavoriteEvent {
  final FavoriteMovieModel movie;

  const AddFavorite(this.movie);
}

class RemoveFavorite
    extends FavoriteEvent {
  final int movieId;

  const RemoveFavorite(this.movieId);
}