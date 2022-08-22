part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();
}

class NowPlayingLoadDataEvent extends NowPlayingEvent {
  const NowPlayingLoadDataEvent();
  @override
  List<Object?> get props => [];
}

class NowPlayingSortByPopularityEvent extends NowPlayingEvent {
  const NowPlayingSortByPopularityEvent();
  @override
  List<Object?> get props => [];
}

class NowPlayingSortByRateEvent extends NowPlayingEvent {
  const NowPlayingSortByRateEvent();
  @override
  List<Object?> get props => [];
}

class NowPlayingSortByDateEvent extends NowPlayingEvent {
  const NowPlayingSortByDateEvent();
  @override
  List<Object?> get props => [];
}

class NowPlayingSortByVoteEvent extends NowPlayingEvent {
  const NowPlayingSortByVoteEvent();
  @override
  List<Object?> get props => [];
}

class NowPlayingSearchEvent extends NowPlayingEvent {
  const NowPlayingSearchEvent({required this.searchedText});
  final String searchedText;
  @override
  List<Object?> get props => [searchedText];
}
