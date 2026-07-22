import 'package:movies_explorer/core/constants/app_strings.dart';
import 'package:movies_explorer/features/movie/data/models/movie_response.dart';

import '../datasource/movie_api.dart';

class MovieRepository {
  final MovieApi movieApi;
  const MovieRepository(this.movieApi);



  Future<MovieResponse> getTrendingMovies(int page) async{
    final response = await movieApi.getMovies(AppStrings.trendingMovies, page);
    return response;
  }

  Future<MovieResponse> getPopularMovies(int page) async{
    final response = await movieApi.getMovies(AppStrings.popularMovies, page);
    return response;
  }

  Future<MovieResponse> getTopRatedMovies(int page) async{
    final  response = await movieApi.getMovies(AppStrings.topRatedMovies, page);
    return response;
  }

  Future<MovieResponse> getUpcomingMovies(int page) async{
    final  response = await movieApi.getMovies(AppStrings.upcomingMovies, page);
    return response;
  }



}