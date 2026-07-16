import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/core/widgets/custom_text.dart';
import 'package:movies_explorer/features/movie/data/models/movie_response.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_event.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_state.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(LoadTrendingMovies(page: 1));
    context.read<MovieBloc>().add(LoadTopMovies(page: 1));
    context.read<MovieBloc>().add(LoadPopularMovies(page: 1));
    context.read<MovieBloc>().add(LoadUpcomingMovies(page: 1));

    return Scaffold(
      appBar: AppBar(title: const Text('Movie Explorer'), centerTitle: true),
      body: ListView(
        children: [
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieSectionWidget(
                    title: "Trending Movies",
                    state: state,
                    movieSectionType: MovieSectionType.trendingMovieSection,
                  ),
                  MovieSectionWidget(
                    title: "Popular Movies",
                    state: state,
                    movieSectionType: MovieSectionType.popularMovieSection,
                  ),
                  MovieSectionWidget(
                    title: "Top Rated Movies",
                    state: state,
                    movieSectionType: MovieSectionType.topRatedMovieSection,
                  ),
                  MovieSectionWidget(
                    title: "Upcoming Movies",
                    state: state,
                    movieSectionType: MovieSectionType.upcomingMovieSection,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class MovieSectionWidget extends StatelessWidget {
  final String title;

  final MovieState state;

  final MovieSectionType movieSectionType;

  const MovieSectionWidget({
    super.key,
    required this.title,
    required this.state,
    required this.movieSectionType,
  });

  Widget createList(MovieState state) {
    // Widget widget;
    List<Results> list = [];
    bool isLoading = true;
    bool isFailed = false;
    String? message;
    switch (movieSectionType) {
      case MovieSectionType.trendingMovieSection:
        if (state.trendingStatus == LoadingStatus.loading) {
          isLoading = true;
        }

        if (state.trendingStatus == LoadingStatus.success) {
          isLoading = false;
          list = state.trendingMovies;
        }

        if (state.trendingStatus == LoadingStatus.failure) {
          isLoading = false;
          isFailed = true;
          message = state.trendingError;
        }

        break;

      case MovieSectionType.popularMovieSection:
        if (state.popularStatus == LoadingStatus.loading) {
          isLoading = true;
        }

        if (state.popularStatus == LoadingStatus.success) {
          isLoading = false;
          list = state.popularMovies;
        }

        if (state.popularStatus == LoadingStatus.failure) {
          isLoading = false;
          isFailed = true;
          message = state.popularError;
        }
        break;

      case MovieSectionType.topRatedMovieSection:
        if (state.topRatedStatus == LoadingStatus.loading) {
          isLoading = true;
        }

        if (state.topRatedStatus == LoadingStatus.success) {
          isLoading = false;
          list = state.topRatedMovies;
        }

        if (state.topRatedStatus == LoadingStatus.failure) {
          isLoading = false;
          isFailed = true;
          message = state.topRatedError;
        }
        break;

      case MovieSectionType.upcomingMovieSection:
        if (state.upcomingStatus == LoadingStatus.loading) {
          isLoading = true;
        }

        if (state.upcomingStatus == LoadingStatus.success) {
          isLoading = false;
          list = state.upcomingMovies;
        }

        if (state.upcomingStatus == LoadingStatus.failure) {
          isLoading = false;
          isFailed = true;
          message = state.upcomingError;
        }
        break;
    }


    return Builder(builder: (context){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const CircularProgressIndicator()],
            ),
          ],
          if (isFailed) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                IconButton(onPressed: (){

                  switch(movieSectionType){
                    case MovieSectionType.trendingMovieSection:
                      context.read<MovieBloc>().add(LoadTrendingMovies(page: 1));
                      break;

                    case MovieSectionType.popularMovieSection:
                      context.read<MovieBloc>().add(LoadPopularMovies(page: 1));
                      break;

                    case MovieSectionType.topRatedMovieSection:
                      context.read<MovieBloc>().add(LoadTopMovies(page: 1));
                      break;

                    case MovieSectionType.upcomingMovieSection:
                      context.read<MovieBloc>().add(LoadUpcomingMovies(page: 1));
                      break;
                  }
                }, icon: Icon(Icons.refresh))
              ],
            ),
          ],
          if (!isLoading && list.isNotEmpty) ...[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                //shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final movie = list[index];

                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            child: CachedNetworkImage(
                              width: 160,
                              imageUrl: movie.posterUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (_, __, ___) =>
                              const Icon(Icons.movie_outlined, size: 60),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              movie.title ?? "No title",
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              softWrap: true,
                              movie.releaseDate ?? "No year",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: .center,
              children: [Expanded(child: createList(state))],
            ),
          ),
        ],
      ),
    );
  }
}

enum MovieSectionType {
  trendingMovieSection,
  popularMovieSection,
  topRatedMovieSection,
  upcomingMovieSection,
}

class Movie {
  final String title;
  final String year;

  Movie(this.title, this.year);
}
