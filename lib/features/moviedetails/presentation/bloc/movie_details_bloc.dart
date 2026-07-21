import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/features/moviedetails/repositories/movie_details_repository.dart';

import '../../../../core/utils/helper.dart';
import '../../models/CastModel.dart';
import '../../models/movie_details_model.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc
    extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsRepository repository;

  MovieDetailsBloc({
    required this.repository,
  }) : super(const MovieDetailsState()) {
    on<LoadMovieDetails>(_onLoadMovieDetails);
  }

  Future<void> _onLoadMovieDetails(
      LoadMovieDetails event,
      Emitter<MovieDetailsState> emit,
      ) async {
    emit(
      state.copyWith(
        status: LoadingStatus.loading,
      ),
    );

    try {
      final results = await Future.wait([
        repository.getMovieDetails(event.movieId.toString()),
        repository.getMovieCast(event.movieId.toString()),
      ]);

      emit(
        state.copyWith(
          status: LoadingStatus.success,
          movie: results[0] as MovieDetailsModel,
          cast: results[1] as CastModel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoadingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}