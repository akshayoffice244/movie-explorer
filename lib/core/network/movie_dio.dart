import 'package:dio/dio.dart';

class MovieDio {
  static Dio create(){
    return Dio(
        BaseOptions(

            baseUrl: "https://api.themoviedb.org/3",
            connectTimeout: const Duration(seconds: 120),
            receiveTimeout: const Duration(seconds: 120),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YTExYzEzODVhZGIyYmFiYmU1YzVjOGI0YWVjYWJjYyIsIm5iZiI6MTc4MzkyNzM3NS42MjUsInN1YiI6IjZhNTQ5MjRmNWE3Y2NiMTk5MWRjY2M2YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2LpWw0FPUba73lLhd_iOUkNgYjF0wS0FlNxCiiP-gRM'
            }

        )
    );
  }
}