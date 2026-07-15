import 'package:dio/dio.dart';
import 'package:movies_explorer/core/network/api_exception.dart';
import 'package:movies_explorer/features/auth/data/models/login_response.dart';

import '../../../../core/utils/helper.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      String message = Helper.extractError(e);
      throw ApiException(message: message, statusCode: e.response?.statusCode);
    }
  }
}
