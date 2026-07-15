import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingMovies = [
      Movie("Dune: Part Two", "2024"),
      Movie("Deadpool & Wolverine", "2024"),
      Movie("Inside Out 2", "2024"),
    ];

    final popularMovies = [
      Movie("Oppenheimer", "2023"),
      Movie("Barbie", "2023"),
      Movie("The Batman", "2022"),
    ];

    final topRatedMovies = [
      Movie("The Shawshank Redemption", "1994"),
      Movie("The Godfather", "1972"),
      Movie("The Dark Knight", "2008"),
    ];

    final upcomingMovies = [
      Movie("Avatar 3", "2026"),
      Movie("Spider-Man 4", "2026"),
      Movie("The Batman Part II", "2027"),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Movie Explorer'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildSection(title: "Trending Movies", movies: trendingMovies),
            _buildSection(title: "Popular Movies", movies: popularMovies),
            _buildSection(title: "Top Rated Movies", movies: topRatedMovies),
            _buildSection(title: "Upcoming Movies", movies: upcomingMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Movie> movies}) {
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final movie = movies[index];

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
                          child: const Center(
                            child: Icon(
                              Icons.movie,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            movie.title,
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
                            movie.year,
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
      ),
    );
  }
}

class Movie {
  final String title;
  final String year;

  Movie(this.title, this.year);
}
