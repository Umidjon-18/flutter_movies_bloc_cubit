part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();
}

class PopularLoadDataEvent extends PopularEvent {
  const PopularLoadDataEvent();
  @override
  List<Object?> get props => [];
}

class PopularSortByPopularityEvent extends PopularEvent {
  const PopularSortByPopularityEvent();
  @override
  List<Object?> get props => [];
}

class PopularSortByRateEvent extends PopularEvent {
  const PopularSortByRateEvent();
  @override
  List<Object?> get props => [];
}

class PopularSortByDateEvent extends PopularEvent {
  const PopularSortByDateEvent();
  @override
  List<Object?> get props => [];
}

class PopularSortByVoteEvent extends PopularEvent {
  const PopularSortByVoteEvent();
  @override
  List<Object?> get props => [];
}

class PopularSearchEvent extends PopularEvent {
  const PopularSearchEvent({required this.searchedText});
  final String searchedText;
  @override
  List<Object?> get props => [searchedText];
}
