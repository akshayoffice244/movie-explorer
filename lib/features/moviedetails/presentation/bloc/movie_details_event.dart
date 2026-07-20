abstract class MovieDetailsEvent {
  const MovieDetailsEvent();
}

class LoadMovieDetails extends MovieDetailsEvent {
  final int movieId;

  const LoadMovieDetails(this.movieId);
}