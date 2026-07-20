import 'package:dio/dio.dart';
import 'package:movies_explorer/features/moviedetails/models/CastModel.dart';
import 'package:movies_explorer/features/moviedetails/models/movie_details_model.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/utils/helper.dart';

class MovieDetailsApi {

  final Dio dio;

  MovieDetailsApi(this.dio);

  Future<MovieDetailsModel> getMovieDetails(String id) async {
    try {
      final response = await dio.get(
        "/movie/${id}",

        queryParameters: {"language": "en-US", },
      );


      print("Response: ${response.data}");
      return MovieDetailsModel.fromJson(response.data);

    } on DioException catch (e) {

      String message = Helper.extractError(e);
      print("Dio Exception: status: ${e.response?.statusCode} $message");
      throw ApiException(message: message, statusCode: e.response?.statusCode);
    }catch(e){
      print("Exception: status: ${e}");

      throw ApiException(message: e.toString());
    }
  }


  Future<CastModel> getMovieCast(String id) async {
    try {
      final response = await dio.get(
        "/movie/${id}/credits",

        queryParameters: {"language": "en-US", },
      );


      print("Response: ${response.data}");
      return CastModel.fromJson(response.data);

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