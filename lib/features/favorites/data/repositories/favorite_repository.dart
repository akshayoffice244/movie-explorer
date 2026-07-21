import 'package:hive/hive.dart';
import 'package:movies_explorer/features/favorites/data/models/favorite_movie_model.dart';

class FavoriteRepository {
  static const boxName = "favorites";


  Box<FavoriteMovieModel> get _box => Hive.box<FavoriteMovieModel>(boxName);


  Future<void> addFavorite(FavoriteMovieModel movie) async{
    await _box.put(movie.id, movie);
  }


  Future<void> removeFavorite(
      int movieId,
      ) async {
    await _box.delete(movieId);
  }

  bool isFavorite(int movieId) {
    return _box.containsKey(movieId);
  }

  List<FavoriteMovieModel> getFavorites() {
    return _box.values.toList();
  }
}