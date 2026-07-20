import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/helper.dart';
import '../../../movie/data/models/movie_response.dart';
import '../../../moviedetails/presentation/pages/movie_details_screen.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    context.read<SearchBloc>().add(
      LoadRecentSearches(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) {
      context.read<SearchBloc>().add(
        LoadRecentSearches(),
      );
      return;
    }

    context.read<SearchBloc>().add(
      SearchMovie(query.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Movies"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: _onSearch,
              decoration: InputDecoration(
                hintText: "Search movies...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();

                    context.read<SearchBloc>().add(
                      LoadRecentSearches(),
                    );
                  },
                  icon: const Icon(Icons.close),
                ),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child:
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (_searchController.text.isEmpty) {
                  return _buildRecentSearches(
                    context,
                    state,
                  );
                }

                switch (state.status) {
                  case LoadingStatus.loading:
                    return const Center(
                      child:
                      CircularProgressIndicator(),
                    );

                  case LoadingStatus.failure:
                    return Center(
                      child: Text(
                        state.errorMessage ??
                            "Something went wrong",
                      ),
                    );

                  case LoadingStatus.success:
                    if (state.movies.isEmpty) {
                      return const Center(
                        child:
                        Text("No movies found"),
                      );
                    }

                    return _buildMovieResults(
                      state.movies,
                    );

                  case LoadingStatus.initial:
                    return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches(
      BuildContext context,
      SearchState state,
      ) {
    if (state.recentSearches.isEmpty) {
      return const Center(
        child: Text(
          "No recent searches",
        ),
      );
    }

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<SearchBloc>()
                      .add(
                    ClearRecentSearches(),
                  );
                },
                child: const Text(
                  "Clear All",
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount:
            state.recentSearches.length,
            itemBuilder:
                (context, index) {
              final query =
              state.recentSearches[index];

              return ListTile(
                leading:
                const Icon(Icons.history),
                title: Text(query),
                trailing: IconButton(
                  icon:
                  const Icon(Icons.close),
                  onPressed: () {
                    context
                        .read<SearchBloc>()
                        .add(
                      DeleteRecentSearch(
                        query,
                      ),
                    );
                  },
                ),
                onTap: () {
                  _searchController.text =
                      query;

                  context
                      .read<SearchBloc>()
                      .add(
                    SearchMovie(query),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieResults(
      List<Results> movies,
      ) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return ListTile(
          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),

          leading: ClipRRect(
            borderRadius:
            BorderRadius.circular(8),
            child: movie.posterPath == null
                ? Container(
              width: 60,
              color: Colors.grey,
              child: const Icon(
                Icons.movie,
              ),
            )
                : Image.network(
              'https://image.tmdb.org/t/p/w200${movie.posterPath}',
              width: 60,
              fit: BoxFit.cover,
            ),
          ),

          title: Text(
            movie.title ?? 'No Title',
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
          ),

          subtitle: Text(
            movie.releaseDate ??
                'Unknown Date',
          ),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    MovieDetailsScreen(
                      movieId: movie.id!,
                    ),
              ),
            );
          },
        );
      },
    );
  }
}