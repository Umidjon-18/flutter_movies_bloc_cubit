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

class PopularIsError extends PopularState {
  const PopularIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}