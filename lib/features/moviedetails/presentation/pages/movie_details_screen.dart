import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/features/favorites/data/models/favorite_movie_model.dart';
import 'package:movies_explorer/features/moviedetails/repositories/movie_details_repository.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../favorites/data/repositories/favorite_repository.dart';
import '../../../favorites/presentation/bloc/favorite_bloc.dart';
import '../../../favorites/presentation/bloc/favorite_event.dart';
import '../../../favorites/presentation/bloc/favorite_state.dart';
import '../../models/CastModel.dart';
import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';
import 'movie_details_view.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: CustomText(text: "Details"),),
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state.status == LoadingStatus.loading) {
            return Column(
              children: [
                AppBar(title: CustomText(text: "Movie details")),
               Expanded(child: Column(
                 mainAxisAlignment: .center,
                 crossAxisAlignment: .center,
                 children: [
                   const Center(child: CircularProgressIndicator()),
                 ],
               ))

              ],
            );
          }

          if (state.status == LoadingStatus.failure) {
            return Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                AppBar(title: CustomText(text: "Movie details")),
               Expanded(child: Column(
                 mainAxisAlignment: .center,
                 crossAxisAlignment: .center,
                 children: [
                   Center(child: CustomText(text: state.errorMessage ?? "")),
                   IconButton(
                     onPressed: () {
                       context.read<MovieDetailsBloc>().add(
                         LoadMovieDetails(movieId),
                       );
                     },
                     icon: Icon(Icons.refresh, size: 20),
                   ),
                 ],
               ))
              ],
            );
          }

          if (state.status == LoadingStatus.success) {
            final movie = state.movie;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  actions: [
                    BlocBuilder<
                        FavoriteBloc,
                        FavoriteState>(
                      builder: (context, state) {
                        final isFavorite = context
                            .read<FavoriteRepository>()
                            .isFavorite(movie?.id ?? 0);

                        return IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              context
                                  .read<FavoriteBloc>()
                                  .add(
                                RemoveFavorite(
                                  movie?.id ?? 0,
                                ),
                              );
                            } else {
                              context
                                  .read<FavoriteBloc>()
                                  .add(
                                AddFavorite(
                                  FavoriteMovieModel(
                                    id: movie?.id ?? 0,
                                    title:
                                    movie?.title ?? '',
                                    posterPath:
                                    movie?.posterPath,
                                    releaseDate:
                                    movie?.releaseDate,
                                    voteAverage:
                                    movie?.voteAverage,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "${AppStrings.imageBaseUrl}${movie?.backdropPath}" ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "${AppStrings.imageBaseUrl}${movie?.posterPath}",
                                width: 120,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie?.title ?? "",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie?.voteAverage?.toString() ?? "",
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  Text("Release Date: ${movie?.releaseDate}"),

                                  const SizedBox(height: 8),

                                  Text("Runtime: ${movie?.runtime} min"),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        Text(
                          "Genres",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: movie!.genres!
                              .map(
                                (genre) => Chip(label: Text(genre?.name ?? "")),
                              )
                              .toList(),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          "Overview",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        const SizedBox(height: 8),

                        Text(movie?.overview ?? ""),

                        const SizedBox(height: 24),

                        Text(
                          "Cast",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.cast?.cast?.length,
                            itemBuilder: (context, index) {
                              Cast? cast = state.cast?.cast?[index];

                              return Container(
                                width: 110,
                                margin: const EdgeInsets.only(right: 12),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: cast?.profilePath == null
                                          ? null
                                          : NetworkImage(
                                              "${AppStrings.imageBaseUrl}${cast?.profilePath}",
                                            ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      cast?.name ?? "",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
