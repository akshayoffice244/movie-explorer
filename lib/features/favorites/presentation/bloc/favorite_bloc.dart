import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/favorite_repository.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc
    extends Bloc<
        FavoriteEvent,
        FavoriteState> {
  final FavoriteRepository repository;

  FavoriteBloc({
    required this.repository,
  }) : super(
    FavoriteState(
      favorites:
      repository.getFavorites(),
    ),
  ) {
    on<LoadFavorites>(
      _onLoadFavorites,
    );

    on<AddFavorite>(
      _onAddFavorite,
    );

    on<RemoveFavorite>(
      _onRemoveFavorite,
    );
  }

  void _onLoadFavorites(
      LoadFavorites event,
      Emitter<FavoriteState> emit,
      ) {
    emit(
      state.copyWith(
        favorites:
        repository.getFavorites(),
      ),
    );
  }

  Future<void> _onAddFavorite(
      AddFavorite event,
      Emitter<FavoriteState> emit,
      ) async {
    await repository.addFavorite(
      event.movie,
    );

    emit(
      state.copyWith(
        favorites:
        repository.getFavorites(),
      ),
    );
  }

  Future<void> _onRemoveFavorite(
      RemoveFavorite event,
      Emitter<FavoriteState> emit,
      ) async {
    await repository.removeFavorite(
      event.movieId,
    );

    emit(
      state.copyWith(
        favorites:
        repository.getFavorites(),
      ),
    );
  }
}