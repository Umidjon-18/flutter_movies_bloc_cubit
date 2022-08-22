part of 'youtube_bloc.dart';

abstract class YoutubeState extends Equatable {
  const YoutubeState();
}

class YoutubeInitial extends YoutubeState {
  const YoutubeInitial();
  @override
  List<Object?> get props => [];
}

class YoutubeIsLoading extends YoutubeState {
  const YoutubeIsLoading();

  @override
  List<Object?> get props => [];
}

class YoutubeIsLoaded extends YoutubeState {
  const YoutubeIsLoaded({required this.youtubeVideos, required this.movieId});
  final Map youtubeVideos;
  final String movieId;
  @override
  List<Object?> get props => [youtubeVideos, movieId];
}

class YoutubeDisconnected extends YoutubeState {
  const YoutubeDisconnected();
  @override
  List<Object?> get props => [];
}

class YoutubeIsError extends YoutubeState {
  const YoutubeIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
