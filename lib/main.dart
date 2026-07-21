import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_explorer/core/constants/app_strings.dart';
import 'package:movies_explorer/core/network/auth_dio.dart';
import 'package:movies_explorer/core/network/movie_dio.dart';
import 'package:movies_explorer/features/auth/data/datasource/auth_api.dart';
import 'package:movies_explorer/features/auth/data/repositories/auth_repository.dart';
import 'package:movies_explorer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movies_explorer/features/auth/presentation/pages/login_page.dart';
import 'package:movies_explorer/features/favorites/data/models/favorite_movie_model.dart';
import 'package:movies_explorer/features/favorites/data/repositories/favorite_repository.dart';
import 'package:movies_explorer/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:movies_explorer/features/movie/data/datasource/movie_api.dart';
import 'package:movies_explorer/features/movie/data/repositories/movie_repository.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movies_explorer/features/movie/presentation/pages/movie_page.dart';
import 'package:movies_explorer/features/movie/presentation/pages/view_all_page.dart';
import 'package:movies_explorer/features/moviedetails/data/movie_details_api.dart';
import 'package:movies_explorer/features/moviedetails/presentation/bloc/movie_details_bloc.dart';
import 'package:movies_explorer/features/moviedetails/repositories/movie_details_repository.dart';
import 'package:movies_explorer/features/search/data/datasource/search_api.dart';
import 'package:movies_explorer/features/search/data/repositories/movie_search_repository.dart';
import 'package:movies_explorer/features/search/data/repositories/recent_search_repository.dart';
import 'package:movies_explorer/features/search/presentation/bloc/search_bloc.dart';
import 'package:movies_explorer/features/theme/bloc/theme_bloc.dart';
import 'package:movies_explorer/features/theme/bloc/theme_state.dart';
import 'package:movies_explorer/features/theme/repository/theme_repository.dart';

import 'core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox<String>('recent_searches');
  await Hive.openBox('theme_box');
  Hive.registerAdapter(FavoriteMovieModelAdapter());

  await Hive.openBox<FavoriteMovieModel>('favorites');
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(AuthApi(AuthDio.create())),
        ),

        RepositoryProvider<MovieRepository>(
          create: (_) => MovieRepository(MovieApi(MovieDio.create())),
        ),

        RepositoryProvider<MovieSearchRepository>(
          create: (_) => MovieSearchRepository(SearchApi(MovieDio.create())),
        ),

        RepositoryProvider<RecentSearchRepository>(
          create: (_) => RecentSearchRepository(),
        ),

        RepositoryProvider<MovieDetailsRepository>(
          create: (_) =>
              MovieDetailsRepository(MovieDetailsApi(MovieDio.create())),
        ),
        RepositoryProvider<FavoriteRepository>(
          create: (_) =>
              FavoriteRepository()),
        
        RepositoryProvider<ThemeRepository>(create: (_) => ThemeRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),

          BlocProvider(
            create: (context) => MovieBloc(context.read<MovieRepository>()),
          ),

          BlocProvider(
            create: (context) => SearchBloc(
              movieRepository: context.read<MovieSearchRepository>(),
              recentSearchRepository: context.read<RecentSearchRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => MovieDetailsBloc(
              repository: context.read<MovieDetailsRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) =>
                ThemeBloc(repository: context.read<ThemeRepository>()),
          ),

          BlocProvider(
            create: (context) =>
               FavoriteBloc(repository: context.read<FavoriteRepository>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          initialRoute: AppStrings.viewAll,
          routes: {
            AppStrings.loginScreen: (_) => const LoginPage(),
            AppStrings.homeScreen: (_) => const MoviePage(),
            AppStrings.viewAll: (_) => const ViewAllPage(),
          },
          //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
