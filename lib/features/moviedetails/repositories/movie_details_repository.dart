import 'package:movies_explorer/features/moviedetails/data/movie_details_api.dart';
import 'package:movies_explorer/features/moviedetails/models/CastModel.dart';
import 'package:movies_explorer/features/moviedetails/models/movie_details_model.dart';

class MovieDetailsRepository {
  final MovieDetailsApi movieApi;
  const MovieDetailsRepository(this.movieApi);



  Future<MovieDetailsModel?> getMovieDetails(String id) async{
    final response = await movieApi.getMovieDetails(id);
    return response;
  }

  Future<CastModel?> getMovieCast(String id) async{
    final response = await movieApi.getMovieCast(id);
    return response;
  }
}