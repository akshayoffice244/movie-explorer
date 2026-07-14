import 'package:movies_explorer/features/auth/data/datasource/auth_api.dart';
import 'package:movies_explorer/features/auth/data/models/login_response.dart';

class AuthRepository {
  final AuthApi authApi;


   AuthRepository(this.authApi);

   Future<LoginResponse>  login({required String email,required String password}) async {

     return authApi.login(email, password);

   }


}