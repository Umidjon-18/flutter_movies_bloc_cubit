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
class UpcomingDisconnected extends UpcomingState {
  const UpcomingDisconnected();
  @override
  List<Object?> get props => [];
}

class UpcomingIsError extends UpcomingState {
  const UpcomingIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}

class UpcomingSortedByPopularity extends UpcomingState {
  const UpcomingSortedByPopularity({required this.upcomingMovies});
  final List<UpcomingMovieModel> upcomingMovies;
  @override
  List<Object?> get props => [upcomingMovies];
}


class UpcomingSortedByRate extends UpcomingState {
  const UpcomingSortedByRate({required this.upcomingMovies});
  final List<UpcomingMovieModel> upcomingMovies;
  @override
  List<Object?> get props => [upcomingMovies];
}

class UpcomingSortedByDate extends UpcomingState {
  const UpcomingSortedByDate({required this.upcomingMovies});
  final List<UpcomingMovieModel> upcomingMovies;
  @override
  List<Object?> get props => [upcomingMovies];
}

class UpcomingSortedByVote extends UpcomingState {
  const UpcomingSortedByVote({required this.upcomingMovies});
  final List<UpcomingMovieModel> upcomingMovies;
  @override
  List<Object?> get props => [upcomingMovies];
}
class UpcomingSearch extends UpcomingState {
  const UpcomingSearch({required this.searchedUpcomingMovies});
  final List<UpcomingMovieModel> searchedUpcomingMovies;
  @override
  List<Object?> get props => [searchedUpcomingMovies];
}