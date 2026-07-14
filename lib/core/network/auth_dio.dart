import 'package:dio/dio.dart';

class AuthDio {


  static Dio create(){
    return Dio(
      BaseOptions(

          baseUrl: "https://reqres.in/api",
          connectTimeout: const Duration(seconds: 120),
          receiveTimeout: const Duration(seconds: 120),
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'free_user_3GRlpUbogMp3kKYp0iiOgeH3T7C'
          }

        )
    );
  }
}