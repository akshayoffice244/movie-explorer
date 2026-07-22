import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/core/widgets/custom_text.dart';
import 'package:movies_explorer/core/widgets/loading_widget.dart';
import 'package:movies_explorer/core/widgets/movie_grid_widget.dart';
import 'package:movies_explorer/core/widgets/movie_tile_widget.dart';
import 'package:movies_explorer/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:movies_explorer/features/favorites/presentation/pages/favorites_screen.dart';
import 'package:movies_explorer/features/movie/data/models/movie_response.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_event.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_state.dart';
import 'package:movies_explorer/features/movie/presentation/pages/view_all_page.dart';
import 'package:movies_explorer/features/moviedetails/presentation/bloc/movie_details_bloc.dart';
import 'package:movies_explorer/features/moviedetails/presentation/bloc/movie_details_event.dart';
import 'package:movies_explorer/features/moviedetails/presentation/pages/movie_details_screen.dart';

import '../../../../core/utils/helper.dart';
import '../../../favorites/presentation/bloc/favorite_event.dart';
import '../../../search/presentation/pages/search_screen.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/bloc/theme_event.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(LoadTrendingMovies(page: 1));
    context.read<MovieBloc>().add(LoadTopMovies(page: 1));
    context.read<MovieBloc>().add(LoadPopularMovies(page: 1));
    context.read<MovieBloc>().add(LoadUpcomingMovies(page: 1));
 void loadMovies(MovieSectionType movieSectionType){

   switch (movieSectionType) {
     case MovieSectionType.trendingMovieSection:
       context.read<MovieBloc>().add(
         LoadTrendingMovies(page: 1),
       );
       break;

     case MovieSectionType.popularMovieSection:
       context.read<MovieBloc>().add(
         LoadPopularMovies(page: 1),
       );
       break;

     case MovieSectionType.topRatedMovieSection:
       context.read<MovieBloc>().add(LoadTopMovies(page: 1));
       break;

     case MovieSectionType.upcomingMovieSection:
       context.read<MovieBloc>().add(
         LoadUpcomingMovies(page: 1),
       );
       break;
   }
 }
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Movie Explorer'),

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            onPressed: () {
              context.read<FavoriteBloc>().add(LoadFavorites());

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => FavoritesScreen(),
                ),
              );
            },
            icon: Icon(Icons.favorite),
          ),

          IconButton(
            icon: Icon(
              context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
        ],
      ),
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
                    loadMovies: (){
                      loadMovies(MovieSectionType.trendingMovieSection);
                    },
                  ),
                  MovieSectionWidget(
                    title: "Popular Movies",
                    state: state,
                    loadMovies: (){
                      loadMovies(MovieSectionType.popularMovieSection);
                    },
                    movieSectionType: MovieSectionType.popularMovieSection,
                  ),
                  MovieSectionWidget(
                    title: "Top Rated Movies",
                    state: state,
                    loadMovies: (){
                      loadMovies(MovieSectionType.topRatedMovieSection);
                    },
                    movieSectionType: MovieSectionType.topRatedMovieSection,
                  ),
                  MovieSectionWidget(
                    title: "Upcoming Movies",
                    state: state,
                    loadMovies: (){
                      loadMovies(MovieSectionType.upcomingMovieSection);
                    },
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
  final Axis scrollDirection;
  final MovieSectionType movieSectionType;

  const MovieSectionWidget({
    super.key,
    required this.title,
    required this.state,
    required this.movieSectionType,
     this.scrollDirection = Axis.horizontal,
    required this.loadMovies
  });

  final Function loadMovies;

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

    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LoadingWidget(


                )],
              ),
            ],
            if (isFailed) ...[
              Row(
                mainAxisAlignment:.center ,
                children: [
                  Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: message ?? "Something went wrong!"),
                      IconButton(
                        onPressed: () {
                            loadMovies();
                        },
                        icon: Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ],
              ),
            ],
            if (!isLoading && list.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: scrollDirection,
                  itemCount: list.length,
                  //shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final movie = list[index];

                     if(scrollDirection == Axis.horizontal){
                       return MovieGridWidget(
                         callBack: () {
                           context.read<MovieDetailsBloc>().add(
                             LoadMovieDetails(movie.id ?? 0),
                           );
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) =>
                                   MovieDetailsScreen(movieId: movie.id ?? 0),
                             ),
                           );
                         },
                         movie: movie,
                       );
                     }else{
                       return MovieTileWidget(   callBack: () {
                         context.read<MovieDetailsBloc>().add(
                           LoadMovieDetails(movie.id ?? 0),
                         );
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) =>
                                 MovieDetailsScreen(movieId: movie.id ?? 0),
                           ),
                         );
                       },
                         movie: movie);
                     }
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //View All
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewAllPage(movieSectionType: movieSectionType),
                      ),
                    );
                  },
                  child: CustomText(text: "View All"),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          if(scrollDirection == Axis.horizontal)...[
            SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: .center,
                children: [Expanded(child: createList(state))],
              ),
            ),
          ]else...[
            Expanded(child: createList(state))
          ]

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
