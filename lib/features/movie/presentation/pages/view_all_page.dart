import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/core/widgets/custom_text.dart';
import 'package:movies_explorer/features/movie/data/models/movie_response.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_event.dart';
import 'package:movies_explorer/features/movie/presentation/pages/movie_page.dart';
import 'package:movies_explorer/features/moviedetails/presentation/pages/movie_details_view.dart';

import '../../../../core/utils/helper.dart';
import '../bloc/movie_state.dart';

class ViewAllPage extends StatefulWidget {
  final MovieSectionType movieSectionType;

  const ViewAllPage({super.key, required this.movieSectionType});

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  int totalPages = 103;
  int currentPage = 1;

  bool isLoading = false;
  bool isFailed = false;
  String? message;
  String? title;

  List<int> pages = [1, 2, 3, 4];

  void increase() {
    if (pages.last == currentPage && totalPages - currentPage >= 1 ||
        pages.last == pages.first) {
      List<int> newPages = [];
      for (int i = 0; i < 4; i++) {
        if (totalPages - (currentPage + i) >= 0) {
          newPages.add(currentPage + i);
        }
      }
      pages = newPages;
    }
    if (currentPage < totalPages) {
      currentPage++;
    }
    loadMovies();
  }

  void decrease() {
    if (currentPage > 1) {
      currentPage--;
    }

    if (pages.first == currentPage && pages.first != 1) {
      List<int> newPages = [];
      for (int i = 0; i < 4; i++) {
        if (pages.first - i > 0) {
          newPages.add(pages.first - i);
        }
      }
      pages = newPages.reversed.toList();
    }
    loadMovies();
  }
  
  String appBarTitle(){
    String title = "No title";
    switch (widget.movieSectionType) {
      case MovieSectionType.trendingMovieSection:
        title = "Trending Movies";

        break;
      case MovieSectionType.upcomingMovieSection:
        title  = "Upcoming Movies";
        break;

      case MovieSectionType.topRatedMovieSection:
        title = "Top Rate Movies";
        break;
      case MovieSectionType.popularMovieSection:
        title  = "Popular Movies";
        break;
    }
    
    return title;
  }

  void loadMovies() {
    switch (widget.movieSectionType) {
      case MovieSectionType.trendingMovieSection:
        context.read<MovieBloc>().add(LoadTrendingMovies(page: currentPage));

        break;
      case MovieSectionType.upcomingMovieSection:
        context.read<MovieBloc>().add(LoadUpcomingMovies(page: currentPage));
        break;

      case MovieSectionType.topRatedMovieSection:
        context.read<MovieBloc>().add(LoadTopMovies(page: currentPage));
        break;
      case MovieSectionType.popularMovieSection:
        context.read<MovieBloc>().add(LoadPopularMovies(page: currentPage));
        break;
    }
  }

  
  void loadStatus(MovieState state) {
    switch (widget.movieSectionType) {
      case MovieSectionType.trendingMovieSection:
        title = "Trending Movies";
        if (state.trendingStatus == LoadingStatus.loading) {
          isLoading = true;
        }

        if (state.trendingStatus == LoadingStatus.success) {
          isLoading = false;
          totalPages = state.trendingTotalPage;
        }

        if (state.trendingStatus == LoadingStatus.failure) {
          isLoading = false;
          isFailed = true;
          message = state.trendingError;
        }

        break;

      case MovieSectionType.popularMovieSection:
        title = "Popular Movies";

        if (state.popularStatus == LoadingStatus.loading) {
          isLoading = true;
        }

        if (state.popularStatus == LoadingStatus.success) {
          isLoading = false;
          totalPages = state.popularTotalPage;
        }

        if (state.popularStatus == LoadingStatus.failure) {
          isLoading = false;
          isFailed = true;
          message = state.popularError;
        }
        break;

      case MovieSectionType.topRatedMovieSection:
        title = "Top Rated Movies";
        if (state.topRatedStatus == LoadingStatus.loading) {
          isLoading = true;
        }

        if (state.topRatedStatus == LoadingStatus.success) {
          isLoading = false;
          totalPages = state.topRatedTotalPage;
        }

        if (state.topRatedStatus == LoadingStatus.failure) {
          isLoading = false;
          isFailed = true;
          message = state.topRatedError;
        }
        break;

      case MovieSectionType.upcomingMovieSection:
        title = "Upcoming Movies";
        if (state.upcomingStatus == LoadingStatus.loading) {
          isLoading = true;
        }

        if (state.upcomingStatus == LoadingStatus.success) {
          isLoading = false;
          totalPages = state.upcomingTotalPage;
        }

        if (state.upcomingStatus == LoadingStatus.failure) {
          isLoading = false;
          isFailed = true;
          message = state.upcomingError;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop,result) async{
        currentPage = 1;
        loadMovies();
      },
      child: Scaffold(
        appBar:AppBar(title: CustomText(text: appBarTitle()),),
        body: Column(
          children: [
            BlocBuilder<MovieBloc,MovieState>(builder: (context,state){
              //loadStatus(state);
              return Expanded(
                child: MovieSectionWidget(
                  title: '',
                  state: state,
                  movieSectionType: widget.movieSectionType,
                  scrollDirection: Axis.vertical,
                  loadMovies: () {
                    loadMovies();
                  },
                ),
              );
            }),
      
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: isLoading || currentPage == 1
                        ? null
                        : () {
                      setState(() {
                        decrease();
                      });
                    },
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
      
                  Expanded(
                    child: Center(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsetsGeometry.all(0),

                        scrollDirection: Axis.horizontal,
                        itemCount: pages.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final page = pages[index];
                          final isSelected =
                              page == currentPage;
      
                          return InkWell(
                            borderRadius:
                            BorderRadius.circular(30),

                            child: AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 250,
                              ),
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    : Colors.transparent,
                                borderRadius:
                                BorderRadius.circular(30),
                                border: Border.all(
                                  color: isSelected
                                      ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      : Colors.grey.shade400,
                                ),
                              ),
                              child: Text(
                                page.toString(),
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
      
                  IconButton(
                    onPressed: isLoading || currentPage == totalPages
                        ? null
                        : () {
                      setState(() {
                        increase();
                      });
                    },
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


