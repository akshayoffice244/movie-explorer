import 'package:mockito/annotations.dart';
import 'package:movies_explorer/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:movies_explorer/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movies_explorer/features/moviedetails/presentation/bloc/movie_details_bloc.dart';
import 'package:movies_explorer/features/theme/bloc/theme_bloc.dart';

@GenerateMocks([
  MovieBloc,
  MovieDetailsBloc,
  FavoriteBloc,
  ThemeBloc,
])

void main(){

}