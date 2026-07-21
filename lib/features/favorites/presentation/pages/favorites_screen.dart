import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_bloc.dart';
import '../bloc/favorite_event.dart';
import '../bloc/favorite_state.dart';

class FavoritesScreen
    extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('Favorites'),
      ),
      body: BlocBuilder<
          FavoriteBloc,
          FavoriteState>(
        builder: (context, state) {
          if (state
              .favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorites yet',
              ),
            );
          }

          return ListView.builder(
            itemCount:
            state.favorites.length,
            itemBuilder:
                (context, index) {
              final movie =
              state.favorites[index];

              return ListTile(
                leading:
                movie.posterPath ==
                    null
                    ? const Icon(
                  Icons.movie,
                )
                    : Image.network(
                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                  width: 50,
                ),

                title:
                Text(movie.title),

                subtitle: Text(
                  movie.releaseDate ??
                      '',
                ),

                trailing:
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    context
                        .read<
                        FavoriteBloc>()
                        .add(
                      RemoveFavorite(
                        movie.id,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}