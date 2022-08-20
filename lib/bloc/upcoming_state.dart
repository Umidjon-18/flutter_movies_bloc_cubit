part of 'upcoming_bloc.dart';

abstract class UpcomingState extends Equatable {
  const UpcomingState();

}


class UpcomingInitial extends UpcomingState {
  const UpcomingInitial();
  @override
  List<Object?> get props => [];
}

class UpcomingIsLoading extends UpcomingState {
  const UpcomingIsLoading();

  @override
  List<Object?> get props => [];
}

class UpcomingIsLoaded extends UpcomingState {
  const UpcomingIsLoaded({required this.upcomingMovies});
  final List<UpcomingMovieModel> upcomingMovies;
  @override
  List<Object?> get props => [upcomingMovies];
}

class UpcomingIsError extends UpcomingState {
  const UpcomingIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}