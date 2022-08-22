part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();
}

class NowPlayingInitial extends NowPlayingState {
  const NowPlayingInitial();
  @override
  List<Object?> get props => [];
}

class NowPlayingIsLoading extends NowPlayingState {
  const NowPlayingIsLoading();

  @override
  List<Object?> get props => [];
}

class NowPlayingIsLoaded extends NowPlayingState {
  const NowPlayingIsLoaded({required this.nowPlayingMovies});
  final List<NowPlayingMovieModel> nowPlayingMovies;
  @override
  List<Object?> get props => [nowPlayingMovies];
}
class NowPlayingDisconnected extends NowPlayingState {
  const NowPlayingDisconnected();
  @override
  List<Object?> get props => [];
}

class NowPlayingIsError extends NowPlayingState {
  const NowPlayingIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}

class NowPlayingSortedByPopularity extends NowPlayingState {
  const NowPlayingSortedByPopularity({required this.nowPlayingMovies});
  final List<NowPlayingMovieModel> nowPlayingMovies;
  @override
  List<Object?> get props => [nowPlayingMovies];
}

class NowPlayingSortedByRate extends NowPlayingState {
  const NowPlayingSortedByRate({required this.nowPlayingMovies});
  final List<NowPlayingMovieModel> nowPlayingMovies;
  @override
  List<Object?> get props => [nowPlayingMovies];
}

class NowPlayingSortedByDate extends NowPlayingState {
  const NowPlayingSortedByDate({required this.nowPlayingMovies});
  final List<NowPlayingMovieModel> nowPlayingMovies;
  @override
  List<Object?> get props => [nowPlayingMovies];
}

class NowPlayingSortedByVote extends NowPlayingState {
  const NowPlayingSortedByVote({required this.nowPlayingMovies});
  final List<NowPlayingMovieModel> nowPlayingMovies;
  @override
  List<Object?> get props => [nowPlayingMovies];
}

class NowPlayingSearch extends NowPlayingState {
  const NowPlayingSearch({required this.searchedNowPlayingMovies});
  final List<NowPlayingMovieModel> searchedNowPlayingMovies;
  @override
  List<Object?> get props => [searchedNowPlayingMovies];
}


