abstract class MovieEvent {
  const MovieEvent();
}


class LoadTrendingMovies extends MovieEvent {

  final int page;
  const LoadTrendingMovies({required this.page});
}


class LoadingPopularMovies extends MovieEvent {
  final int page;
  const LoadingPopularMovies({ required this.page});

}

class LoadTopMovies extends MovieEvent {
  final int page;
  const LoadTopMovies({ required this.page});

}


class LoadUpcomingMovies extends MovieEvent {
  final int page;
  const LoadUpcomingMovies({ required this.page});

}