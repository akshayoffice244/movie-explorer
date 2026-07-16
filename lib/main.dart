import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/core/constants/app_strings.dart';
import 'package:movies_explorer/core/network/auth_dio.dart';
import 'package:movies_explorer/core/network/movie_dio.dart';
import 'package:movies_explorer/features/auth/data/datasource/auth_api.dart';
import 'package:movies_explorer/features/auth/data/repositories/auth_repository.dart';
import 'package:movies_explorer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movies_explorer/features/auth/presentation/pages/login_page.dart';
import 'package:movies_explorer/features/movie/data/datasource/movie_api.dart';
import 'package:movies_explorer/features/movie/data/repositories/movie_repository.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movies_explorer/features/movie/presentation/pages/movie_page.dart';

import 'core/themes/app_theme.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(AuthApi(AuthDio.create())),
        ),

        RepositoryProvider<MovieRepository>(
          create: (_) => MovieRepository(MovieApi(MovieDio.create())),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),

          BlocProvider(
            create: (context) => MovieBloc(context.read<MovieRepository>()),
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppStrings.homeScreen,
      routes: {
        AppStrings.loginScreen: (_) => const LoginPage(),
        AppStrings.homeScreen: (_) => const MoviePage(),
      },
      //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

