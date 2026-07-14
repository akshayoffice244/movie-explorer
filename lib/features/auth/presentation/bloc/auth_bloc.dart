import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/core/network/api_exception.dart';
import 'package:movies_explorer/features/auth/data/repositories/auth_repository.dart';
import 'package:movies_explorer/features/auth/presentation/bloc/auth_event.dart';
import 'package:movies_explorer/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginSubmitted>(_login);
  }

  Future<void> _login(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(response.token));
      print("Success: ${response.token}");
    } on ApiException catch (e) {
      print("Error: status code ${e.statusCode} message ${e.message}");
      emit(AuthFailure(e.statusCode, e.message));
    } catch (e) {
      print("Error:  message Unexpected error!");
      emit(const AuthFailure(0, "Unexpected error!"));
    }
  }
}
