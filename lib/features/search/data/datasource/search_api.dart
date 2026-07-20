import 'package:dio/dio.dart';
import 'package:movies_explorer/features/movie/data/models/movie_response.dart';
import 'package:movies_explorer/features/moviedetails/models/CastModel.dart';
import 'package:movies_explorer/features/moviedetails/models/movie_details_model.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/helper.dart';


class SearchApi {

  final Dio dio;

  SearchApi(this.dio);

  Future<MovieResponse> searchMovie(String query) async {
    try {
      final response = await dio.get(
        "/search/movie",

        queryParameters: {"language": "en-US",
        "query" : query
        },
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