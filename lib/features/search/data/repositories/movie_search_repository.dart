import 'package:movies_explorer/features/movie/data/models/movie_response.dart';
import 'package:movies_explorer/features/search/data/datasource/search_api.dart';

class MovieSearchRepository {
  final SearchApi searchApi;
  const MovieSearchRepository(this.searchApi);



  Future<List<Results>?> searchMovie(String query) async {
    final response = await searchApi.searchMovie(query);
    return response.results;
  }
}