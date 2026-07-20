import 'package:dio/dio.dart';

class Helper {
  //email validation class
  static bool isValidEmail(String text) {
    // This is a standard rule template for matching emails
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(text);
  }


  /// Criteria:
  /// * Min 8 characters long
  /// * At least 1 uppercase letter
  /// * At least 1 lowercase letter
  /// * At least 1 numeric digit
  /// * At least 1 special character (e.g., !, @, #, $, etc.)
  bool isValidPassword(String password) {
    if (password.isEmpty) return false;

    // Single regex matching all criteria concurrently
    final passwordRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
    );

    return passwordRegex.hasMatch(password);
  }


  static String extractError(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      return data['error'] ??
          data['message'] ??
          'Something went wrong';
    }

    return 'Something went wrong';
  }
}


enum LoadingStatus {
  initial,
  loading,
  success,
  failure,
}