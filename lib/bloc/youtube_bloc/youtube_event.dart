part of 'youtube_bloc.dart';

abstract class YoutubeEvent extends Equatable {
  const YoutubeEvent();
}

class YoutubeLoadDataEvent extends YoutubeEvent {
  const YoutubeLoadDataEvent({required this.movieId});
  final String movieId;
  @override
  List<Object?> get props => [movieId];
}
