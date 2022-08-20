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

class NowPlayingIsError extends NowPlayingState {
  const NowPlayingIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
