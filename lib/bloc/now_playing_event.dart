part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();
}

class NowPlayingLoadDataEvent extends NowPlayingEvent {
  const NowPlayingLoadDataEvent();
  @override
  List<Object?> get props => [];
}
