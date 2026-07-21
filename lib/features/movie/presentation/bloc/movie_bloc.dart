import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/core/network/api_exception.dart';
import 'package:movies_explorer/features/movie/data/models/movie_response.dart';
import 'package:movies_explorer/features/movie/data/repositories/movie_repository.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_event.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_state.dart';

import '../../../../core/utils/helper.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  final MovieRepository movieRepository;
  MovieBloc(this.movieRepository): super(MovieState()){
    on<LoadTrendingMovies>(_loadTrendingMovies);
    on<LoadPopularMovies>(_loadPopularMovies);
    on<LoadTopMovies>(_loadTopRatedMovies);
    on<LoadUpcomingMovies>(_loadUpcomingMovies);

  }


  Future<void> _loadTrendingMovies(LoadTrendingMovies event, Emitter<MovieState> emit) async{
    emit(state.copyWith(trendingStatus: LoadingStatus.loading));
    try{
      List<Results>? movies=  await movieRepository.getTrendingMovies(event.page);
        emit(state.copyWith(trendingStatus: LoadingStatus.success, trendingMovies: movies ?? [] ));
    }on ApiException catch(e){
      emit(state.copyWith(trendingStatus: LoadingStatus.failure ,trendingError: e.message));
    } catch(e){
      emit(state.copyWith(trendingStatus: LoadingStatus.failure ,trendingError: e.toString()));
    }
  }


  Future<void> _loadPopularMovies(LoadPopularMovies event, Emitter<MovieState> emit) async{
    emit(state.copyWith(popularStatus: LoadingStatus.loading));
    try{
      List<Results>? movies=  await movieRepository.getPopularMovies(event.page);
      emit(state.copyWith(popularStatus: LoadingStatus.success, popularMovies: movies ?? [] ));
    }on ApiException catch(e){
      emit(state.copyWith(popularStatus: LoadingStatus.failure ,popularError: e.message));
    } catch(e){
      emit(state.copyWith(popularStatus: LoadingStatus.failure ,popularError: e.toString()));
    }
  }

  Future<void> _loadTopRatedMovies(LoadTopMovies event, Emitter<MovieState> emit) async{
    emit(state.copyWith(topRatedStatus: LoadingStatus.loading));
    try{
      List<Results>? movies=  await movieRepository.getTopRatedMovies(event.page);
      emit(state.copyWith(topRatedStatus: LoadingStatus.success, topRatedMovies: movies ?? [] ));
    }on ApiException catch(e){
      emit(state.copyWith(topRatedStatus: LoadingStatus.failure ,topRatedError: e.message));
    } catch(e){
      emit(state.copyWith(topRatedStatus: LoadingStatus.failure ,topRatedError: e.toString()));
    }
  }


  Future<void> _loadUpcomingMovies(LoadUpcomingMovies event, Emitter<MovieState> emit) async{
    emit(state.copyWith(upcomingStatus: LoadingStatus.loading));
    try{
      List<Results>? movies=  await movieRepository.getUpcomingMovies(event.page);
      emit(state.copyWith(upcomingStatus: LoadingStatus.success, upcomingMovies: movies ?? [] ));
    }on ApiException catch(e){
      emit(state.copyWith(upcomingStatus: LoadingStatus.failure ,upcomingError: e.message));
    } catch(e){
      emit(state.copyWith(upcomingStatus: LoadingStatus.failure ,upcomingError: e.toString()));
    }
  }

}