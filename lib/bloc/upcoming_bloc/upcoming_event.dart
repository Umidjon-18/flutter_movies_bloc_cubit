part of 'upcoming_bloc.dart';

abstract class UpcomingEvent extends Equatable {
  const UpcomingEvent();
}

class UpcomingLoadDataEvent extends UpcomingEvent {
  const UpcomingLoadDataEvent();
  @override
  List<Object?> get props => [];
}

class UpcomingSortByPopularityEvent extends UpcomingEvent {
  const UpcomingSortByPopularityEvent();
  @override
  List<Object?> get props => [];
}

class UpcomingSortByRateEvent extends UpcomingEvent {
  const UpcomingSortByRateEvent();
  @override
  List<Object?> get props => [];
}

class UpcomingSortByDateEvent extends UpcomingEvent {
  const UpcomingSortByDateEvent();
  @override
  List<Object?> get props => [];
}

class UpcomingSortByVoteEvent extends UpcomingEvent {
  const UpcomingSortByVoteEvent();
  @override
  List<Object?> get props => [];
}

class UpcomingSearchEvent extends UpcomingEvent {
  const UpcomingSearchEvent({required this.searchedText});
  final String searchedText;
  @override
  List<Object?> get props => [searchedText];
}
