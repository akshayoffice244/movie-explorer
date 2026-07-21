import 'package:hive/hive.dart';

part 'favorite_movie_model.g.dart';

@HiveType(typeId: 0)
class FavoriteMovieModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? posterPath;

  @HiveField(3)
  final String? releaseDate;

  @HiveField(4)
  final double? voteAverage;

  FavoriteMovieModel({
    required this.id,
    required this.title,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
  });
}
