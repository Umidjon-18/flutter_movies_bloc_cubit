part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();
}

class PopularInitial extends PopularState {
  const PopularInitial();
  @override
  List<Object?> get props => [];
}

class PopularIsLoading extends PopularState {
  const PopularIsLoading();

  @override
  List<Object?> get props => [];
}

class PopularIsLoaded extends PopularState {
  const PopularIsLoaded({required this.popularMovies});
  final List<PopularMovieModel> popularMovies;
  @override
  List<Object?> get props => [popularMovies];
}
class PopularDisconnected extends PopularState {
  const PopularDisconnected();
  @override
  List<Object?> get props => [];
}
class PopularIsError extends PopularState {
  const PopularIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}

class PopularSortedByPopularity extends PopularState {
  const PopularSortedByPopularity({required this.popularMovies});
  final List<PopularMovieModel> popularMovies;
  @override
  List<Object?> get props => [popularMovies];
}

class PopularSortedByRate extends PopularState {
  const PopularSortedByRate({required this.popularMovies});
  final List<PopularMovieModel> popularMovies;
  @override
  List<Object?> get props => [popularMovies];
}

class PopularSortedByDate extends PopularState {
  const PopularSortedByDate({required this.popularMovies});
  final List<PopularMovieModel> popularMovies;
  @override
  List<Object?> get props => [popularMovies];
}

class PopularSortedByVote extends PopularState {
  const PopularSortedByVote({required this.popularMovies});
  final List<PopularMovieModel> popularMovies;
  @override
  List<Object?> get props => [popularMovies];
}


class PopularSearch extends PopularState {
  const PopularSearch({required this.searchedPopularMovies});
  final List<PopularMovieModel> searchedPopularMovies;
  @override
  List<Object?> get props => [searchedPopularMovies];
}
