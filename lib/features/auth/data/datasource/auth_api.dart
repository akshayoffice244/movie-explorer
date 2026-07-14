import 'package:dio/dio.dart';
import 'package:movies_explorer/core/network/api_exception.dart';
import 'package:movies_explorer/features/auth/data/models/login_response.dart';

class AuthApi {

    final Dio dio;

    AuthApi(this.dio);


    Future<LoginResponse> login(String email, String password) async {
      
     try{

       final response = await dio.post('/login',
           data:  {
             'email': email,
             'password': password
           });



       return LoginResponse.fromJson(response.data);
     }on DioException catch(e){
       String message = _extractError(e);
       throw ApiException(message: message, statusCode: e.response?.statusCode);

     }

    }

    String _extractError(DioException e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        return data['error'] ??
            data['message'] ??
            'Something went wrong';
      }

      return 'Something went wrong';
    }


}