import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/core/widgets/custom_text.dart';
import 'package:movies_explorer/features/moviedetails/models/CastModel.dart';

import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_state.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Details"),),
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state.status == LoadingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == LoadingStatus.failure) {
            return Center(child: Text(state.errorMessage ?? ""));
          }

          if (state.status == LoadingStatus.success) {
            final movie = state.movie;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      movie?.backdropPath ?? "",
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
                                movie?.posterPath ?? "",
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

                        // SizedBox(
                        //   height: 170,
                        //   child: ListView.builder(
                        //     scrollDirection:
                        //     Axis.horizontal,
                        //     itemCount: state.cast.length,
                        //     itemBuilder:
                        //         (context, index) {
                        //       CastModel cast =
                        //       state.cast[index];
                        //
                        //       return Container(
                        //         width: 110,
                        //         margin:
                        //         const EdgeInsets.only(
                        //           right: 12,
                        //         ),
                        //         child: Column(
                        //           children: [
                        //             CircleAvatar(
                        //               radius: 40,
                        //               backgroundImage:
                        //               cast.profilePath ==
                        //                   null
                        //                   ? null
                        //                   : NetworkImage(
                        //                 cast.profileUrl,
                        //               ),
                        //             ),
                        //
                        //             const SizedBox(
                        //                 height: 8),
                        //
                        //             Text(
                        //               cast?.name ?? "",
                        //               textAlign:
                        //               TextAlign.center,
                        //               maxLines: 2,
                        //               overflow:
                        //               TextOverflow
                        //                   .ellipsis,
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
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
