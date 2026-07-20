import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/features/moviedetails/repositories/movie_details_repository.dart';

import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import 'movie_details_view.dart';


class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MovieDetailsBloc(
          repository: context.read<MovieDetailsRepository>(),
        )..add(LoadMovieDetails(movieId)),
        child: const MovieDetailsView(),
      ),
    );
  }
}