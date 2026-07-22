import 'package:movies_explorer/features/movie/data/models/movie_response.dart';

import '../../../../core/utils/helper.dart';



class MovieState {
  final LoadingStatus trendingStatus;
  final LoadingStatus popularStatus;
  final LoadingStatus topRatedStatus;
  final LoadingStatus upcomingStatus;

  final int trendingTotalPage;
  final int popularTotalPage ;
  final int topRatedTotalPage;
  final int upcomingTotalPage;

  final List<Results> trendingMovies;
  final List<Results> popularMovies;
  final List<Results> topRatedMovies;
  final List<Results> upcomingMovies;

  final String? trendingError;
  final String? popularError;
  final String? topRatedError;
  final String? upcomingError;
  const MovieState({
    this.trendingStatus = LoadingStatus.initial,
    this.popularStatus = LoadingStatus.initial,
    this.topRatedStatus = LoadingStatus.initial,
    this.upcomingStatus = LoadingStatus.initial,

    this.trendingTotalPage = 1,
    this.popularTotalPage = 1,
    this.topRatedTotalPage = 1,
    this.upcomingTotalPage = 1,
    this.trendingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
    this.trendingError,
    this.popularError,
    this.topRatedError,
    this.upcomingError,
  });



  MovieState copyWith({
    LoadingStatus? trendingStatus,
    LoadingStatus? popularStatus,
    LoadingStatus? topRatedStatus,
    LoadingStatus? upcomingStatus,
    List<Results>? trendingMovies,
    List<Results>? popularMovies,
    List<Results>? topRatedMovies,
    List<Results>? upcomingMovies,
    String? trendingError,
    String? popularError,
    String? topRatedError,
    String? upcomingError,

     int? trendingTotalPage,
     int? popularTotalPage ,
     int? topRatedTotalPage,
     int? upcomingTotalPage,
  }) {
    return MovieState(
      trendingStatus: trendingStatus ?? this.trendingStatus,
      popularStatus: popularStatus ?? this.popularStatus,
      topRatedStatus: topRatedStatus ?? this.topRatedStatus,
      upcomingStatus: upcomingStatus ?? this.upcomingStatus,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      trendingError: trendingError ?? this.trendingError,
      popularError: popularError ?? this.popularError,
      topRatedError: topRatedError ?? this.topRatedError,
      upcomingError: upcomingError ?? this.upcomingError,
        trendingTotalPage: trendingTotalPage ?? this.trendingTotalPage,
        popularTotalPage: popularTotalPage ?? this.popularTotalPage,
      topRatedTotalPage: topRatedTotalPage ?? this.topRatedTotalPage,
      upcomingTotalPage: upcomingTotalPage ?? this.upcomingTotalPage
    );
  }
}

