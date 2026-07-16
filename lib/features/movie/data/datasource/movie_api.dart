import 'package:dio/dio.dart';
import 'package:movies_explorer/features/movie/data/models/movie_response.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/helper.dart';

class MovieApi {
  final Dio dio;

  MovieApi(this.dio);

  Future<MovieResponse> getMovies(String path, int page) async {
    try {
      final response = await dio.get(
        path,

        queryParameters: {"language": "en-US", "page": page},
      );


      print("Response: ${response.data}");
      return MovieResponse.fromJson(response.data);

    } on DioException catch (e) {

      String message = Helper.extractError(e);
      print("Dio Exception: status: ${e.response?.statusCode} $message");
      throw ApiException(message: message, statusCode: e.response?.statusCode);
    }catch(e){
      print("Exception: status: ${e}");

      throw ApiException(message: e.toString());
    }
  }


}
