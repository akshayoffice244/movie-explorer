import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/features/search/data/repositories/movie_search_repository.dart';
import 'package:movies_explorer/features/search/presentation/bloc/search_event.dart';
import 'package:movies_explorer/features/search/presentation/bloc/search_state.dart';
import '../../../../core/utils/helper.dart';
import '../../data/repositories/recent_search_repository.dart';

class SearchBloc
    extends Bloc<SearchEvent, SearchState> {
  final MovieSearchRepository movieRepository;

  final RecentSearchRepository
  recentSearchRepository;

  SearchBloc( {
    required this.movieRepository,
    required this.recentSearchRepository,
  }) : super(const SearchState()) {
    on<SearchMovie>(_onSearchMovie);

    on<LoadRecentSearches>(
      _onLoadRecentSearches,
    );

    on<DeleteRecentSearch>(
      _onDeleteRecentSearch,
    );

    on<ClearRecentSearches>(
      _onClearRecentSearches,
    );
  }

  Future<void> _onSearchMovie(
      SearchMovie event,
      Emitter<SearchState> emit,
      ) async {
    emit(
      state.copyWith(
        status: LoadingStatus.loading,
      ),
    );

    try {
      final movies =
      await movieRepository.searchMovie(
         event.query,
      );

      await recentSearchRepository.saveSearch(
        event.query,
      );

      emit(
        state.copyWith(
          status: LoadingStatus.success,
          movies: movies,
          recentSearches:
          recentSearchRepository
              .getRecentSearches(),
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

  void _onLoadRecentSearches(
      LoadRecentSearches event,
      Emitter<SearchState> emit,
      ) {
    emit(
      state.copyWith(
        recentSearches:
        recentSearchRepository
            .getRecentSearches(),
      ),
    );
  }

  Future<void> _onDeleteRecentSearch(
      DeleteRecentSearch event,
      Emitter<SearchState> emit,
      ) async {
    await recentSearchRepository.removeSearch(
      event.query,
    );

    emit(
      state.copyWith(
        recentSearches:
        recentSearchRepository
            .getRecentSearches(),
      ),
    );
  }

  Future<void> _onClearRecentSearches(
      ClearRecentSearches event,
      Emitter<SearchState> emit,
      ) async {
    await recentSearchRepository.clearAll();

    emit(
      state.copyWith(
        recentSearches: [],
      ),
    );
  }
}