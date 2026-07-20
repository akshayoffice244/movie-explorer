import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/features/theme/bloc/theme_event.dart';
import 'package:movies_explorer/features/theme/bloc/theme_state.dart';

import '../repository/theme_repository.dart';

class ThemeBloc
    extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository repository;

  ThemeBloc({
    required this.repository,
  }) : super(
    ThemeState(
      themeMode:
      repository.getTheme(),
    ),
  ) {
    on<ToggleTheme>(_onToggleTheme);
    on<LoadTheme>(_onLoadTheme);
  }

  Future<void> _onToggleTheme(
      ToggleTheme event,
      Emitter<ThemeState> emit,
      ) async {
    final newTheme =
    state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await repository.saveTheme(
      newTheme,
    );

    emit(
      state.copyWith(
        themeMode: newTheme,
      ),
    );
  }

  void _onLoadTheme(
      LoadTheme event,
      Emitter<ThemeState> emit,
      ) {
    emit(
      state.copyWith(
        themeMode:
        repository.getTheme(),
      ),
    );
  }
}